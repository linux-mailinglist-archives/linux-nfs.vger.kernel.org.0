Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48445CF4AF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2019 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfJHIMJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Oct 2019 04:12:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1191 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727724AbfJHIMI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Oct 2019 04:12:08 -0400
X-IronPort-AV: E=Sophos;i="5.67,270,1566835200"; 
   d="scan'208";a="76641408"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Oct 2019 16:12:05 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 4CAE64CE0C93;
        Tue,  8 Oct 2019 16:12:00 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 8 Oct 2019 16:12:00 +0800
Subject: Re: [PATCH v2 1/2] NFS: Fix O_DIRECT accounting of number of bytes
 read/written
To:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
CC:     <linux-nfs@vger.kernel.org>
References: <20191001202000.13248-1-trond.myklebust@hammerspace.com>
 <20191001202000.13248-2-trond.myklebust@hammerspace.com>
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Message-ID: <6185d0c7-9343-d524-a79d-7a9b2fbb4e1e@cn.fujitsu.com>
Date:   Tue, 8 Oct 2019 16:11:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191001202000.13248-2-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 4CAE64CE0C93.AA906
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

After this patch we have new problem. Sometimes generic/465 test failed.

We capture the packets and find that "read" will read file hole data 
when "write" is going on.

Something like this situation as below,

|xxxxxxxxxxxx|                  |xxxxxxxxxxxxxxxxx|

\-------w-----/\---hole---/\----------w-------/

                              ^

                               R


When "read"/"write" needs more rpc calls,  read rpc call in middle will 
read file hole data.

Because rpc calls in "write" are async, once rpc calls  in "write" are 
out of order then "read" may read hole data.

Maybe we need serialize the r/w in directio mode, what do you think?

Thanks

在 2019/10/2 4:19, Trond Myklebust 写道:
> When a series of O_DIRECT reads or writes are truncated, either due to
> eof or due to an error, then we should return the number of contiguous
> bytes that were received/sent starting at the offset specified by the
> application.
>
> Currently, we are failing to correctly check contiguity, and so we're
> failing the generic/465 in xfstests when the race between the read
> and write RPCs causes the file to get extended while the 2 reads are
> outstanding. If the first read RPC call wins the race and returns with
> eof set, we should treat the second read RPC as being truncated.
>
> Reported-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> Fixes: 1ccbad9f9f9bd ("nfs: fix DIO good bytes calculation")
> Cc: stable@vger.kernel.org # 4.1+
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/direct.c | 82 ++++++++++++++++++++++++++++---------------------
>   1 file changed, 47 insertions(+), 35 deletions(-)
>
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 222d7115db71..62cb4a1a87f0 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -123,32 +123,53 @@ static inline int put_dreq(struct nfs_direct_req *dreq)
>   }
>   
>   static void
> -nfs_direct_good_bytes(struct nfs_direct_req *dreq, struct nfs_pgio_header *hdr)
> +nfs_direct_handle_truncated(struct nfs_direct_req *dreq,
> +			    const struct nfs_pgio_header *hdr,
> +			    ssize_t dreq_len)
>   {
> -	int i;
> -	ssize_t count;
> +	struct nfs_direct_mirror *mirror = &dreq->mirrors[hdr->pgio_mirror_idx];
> +	loff_t hdr_arg = hdr->io_start + hdr->args.count;
> +	ssize_t expected = 0;
> +
> +	if (hdr_arg > dreq->io_start)
> +		expected = hdr_arg - dreq->io_start;
> +
> +	if (dreq_len == expected)
> +		return;
> +	if (dreq->max_count > dreq_len) {
> +		dreq->max_count = dreq_len;
> +		if (dreq->count > dreq_len)
> +			dreq->count = dreq_len;
> +
> +		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
> +			dreq->error = hdr->error;
> +		else if (hdr->good_bytes > 0)
> +			dreq->error = 0;
> +	}
> +	if (mirror->count > dreq_len)
> +		mirror->count = dreq_len;
> +}
>   
> -	WARN_ON_ONCE(dreq->count >= dreq->max_count);
> +static void
> +nfs_direct_count_bytes(struct nfs_direct_req *dreq,
> +		       const struct nfs_pgio_header *hdr)
> +{
> +	struct nfs_direct_mirror *mirror = &dreq->mirrors[hdr->pgio_mirror_idx];
> +	loff_t hdr_end = hdr->io_start + hdr->good_bytes;
> +	ssize_t dreq_len = 0;
>   
> -	if (dreq->mirror_count == 1) {
> -		dreq->mirrors[hdr->pgio_mirror_idx].count += hdr->good_bytes;
> -		dreq->count += hdr->good_bytes;
> -	} else {
> -		/* mirrored writes */
> -		count = dreq->mirrors[hdr->pgio_mirror_idx].count;
> -		if (count + dreq->io_start < hdr->io_start + hdr->good_bytes) {
> -			count = hdr->io_start + hdr->good_bytes - dreq->io_start;
> -			dreq->mirrors[hdr->pgio_mirror_idx].count = count;
> -		}
> -		/* update the dreq->count by finding the minimum agreed count from all
> -		 * mirrors */
> -		count = dreq->mirrors[0].count;
> +	if (hdr_end > dreq->io_start)
> +		dreq_len = hdr_end - dreq->io_start;
>   
> -		for (i = 1; i < dreq->mirror_count; i++)
> -			count = min(count, dreq->mirrors[i].count);
> +	nfs_direct_handle_truncated(dreq, hdr, dreq_len);
>   
> -		dreq->count = count;
> -	}
> +	if (dreq_len > dreq->max_count)
> +		dreq_len = dreq->max_count;
> +
> +	if (mirror->count < dreq_len)
> +		mirror->count = dreq_len;
> +	if (dreq->count < dreq_len)
> +		dreq->count = dreq_len;
>   }
>   
>   /*
> @@ -402,20 +423,12 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
>   	struct nfs_direct_req *dreq = hdr->dreq;
>   
>   	spin_lock(&dreq->lock);
> -	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
> -		dreq->error = hdr->error;
> -
>   	if (test_bit(NFS_IOHDR_REDO, &hdr->flags)) {
>   		spin_unlock(&dreq->lock);
>   		goto out_put;
>   	}
>   
> -	if (hdr->good_bytes != 0)
> -		nfs_direct_good_bytes(dreq, hdr);
> -
> -	if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
> -		dreq->error = 0;
> -
> +	nfs_direct_count_bytes(dreq, hdr);
>   	spin_unlock(&dreq->lock);
>   
>   	while (!list_empty(&hdr->pages)) {
> @@ -652,6 +665,9 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
>   	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
>   
>   	dreq->count = 0;
> +	dreq->max_count = 0;
> +	list_for_each_entry(req, &reqs, wb_list)
> +		dreq->max_count += req->wb_bytes;
>   	dreq->verf.committed = NFS_INVALID_STABLE_HOW;
>   	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
>   	for (i = 0; i < dreq->mirror_count; i++)
> @@ -791,17 +807,13 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
>   	nfs_init_cinfo_from_dreq(&cinfo, dreq);
>   
>   	spin_lock(&dreq->lock);
> -
> -	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
> -		dreq->error = hdr->error;
> -
>   	if (test_bit(NFS_IOHDR_REDO, &hdr->flags)) {
>   		spin_unlock(&dreq->lock);
>   		goto out_put;
>   	}
>   
> +	nfs_direct_count_bytes(dreq, hdr);
>   	if (hdr->good_bytes != 0) {
> -		nfs_direct_good_bytes(dreq, hdr);
>   		if (nfs_write_need_commit(hdr)) {
>   			if (dreq->flags == NFS_ODIRECT_RESCHED_WRITES)
>   				request_commit = true;


