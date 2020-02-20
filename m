Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE07C166663
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2020 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBTSfg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Feb 2020 13:35:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40197 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSff (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Feb 2020 13:35:35 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so5795582iop.7
        for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2020 10:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2uSKY1fuo6hBL7zG319M4u/DNN1CxOOqOXmsLBmB3HM=;
        b=mLAZEnppnFfT1TKqWfgvtOfvz5lR4+MUymmc8oKNl+QW4XBJ2iPcdr7dKUcKpnQPoM
         ibPa395IQSvKF6kXlYf43MIekI6VdPHF7ohQRqsilXoMOhQvFy2MOGm2Ijn4zj8QRwzI
         NjuEhEpyY26M4n8H7ZuG3q+94RicoxxCueEdks3wozeg0kibrn9GsleWVzx4CZnHoM0z
         X262O1ZaOyWbuRGuAyNahY8n+9azQZSXrTyUtzjI+PZw0FNXK3GfrmuZgi4Tp7FsxHFC
         rQ38n0+pmrVBMN0YI6wLmNwFDmaAbwfJpkijcdpuIASwmZqeaiT2StHNc7g10NjvAsMP
         LJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2uSKY1fuo6hBL7zG319M4u/DNN1CxOOqOXmsLBmB3HM=;
        b=CuizMSlEHD9QkymIyf1qpu/OtwYH6eNfUOoD0VPhAk4Z0YngzqSSD+v3MmWhfp+KHv
         cc69MKvaqej972fnRbWSfAelHa6l1cOstwcJOpO0HcypiDV2xZOf6++M2R7e/QP7Tafl
         1nz90Ewt4ZHjn78nBL17+3VGhowumMwN5cCAzbJkmo+ozxHMPLLaLj0dYt8eDiZEn+6C
         sCmNIQeD5QvXMt/znfnesR0cwNIAJ43A7PAqWGUjZv70SYuaHPJiuKqRLdakJ7T86DFU
         h9fjMGOJfOclK+oJC9EXHRao4XrJz+0vziUfYY32696enIVr2ScZTrj2s+hPPsGfsNfO
         ztUw==
X-Gm-Message-State: APjAAAX4wJFit7uC+RkQptV6X37IsYuKEywN3FKns3xh0IK/Z2+X1n2o
        XnAMh0skDOcMfrCAxWm1Q24=
X-Google-Smtp-Source: APXvYqxsFOvyUjwNVTD1O5e584MHaKXsNyQyhptl9UgfZGfiMFOLxZ14DU5WrvRlZEHmkEy8XueNcQ==
X-Received: by 2002:a6b:4f0b:: with SMTP id d11mr24720954iob.117.1582223734384;
        Thu, 20 Feb 2020 10:35:34 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.googlemail.com with ESMTPSA id i18sm38050ioj.59.2020.02.20.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 10:35:33 -0800 (PST)
Message-ID: <2c46295c6a6e748947af226dc470f7e35a2c6e82.camel@gmail.com>
Subject: Re: [PATCH v2 4/6] NFS: Add READ_PLUS data segment support
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond.Myklebust@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 20 Feb 2020 13:35:32 -0500
In-Reply-To: <93E71BBA-029B-44AE-B580-0332E157D0A2@oracle.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
         <20200214211227.407836-5-Anna.Schumaker@Netapp.com>
         <AAF85957-285A-42BF-993D-7EB4843E2ED2@oracle.com>
         <7621b7d84295dd3086e2036f8cb389ceb47cbbc2.camel@gmail.com>
         <CD23428B-4105-4A52-864D-73CFA64E4551@oracle.com>
         <cbff77a5175b448e955fafc45b5c80b3dcff0f5b.camel@gmail.com>
         <93E71BBA-029B-44AE-B580-0332E157D0A2@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-02-20 at 13:30 -0500, Chuck Lever wrote:
> > On Feb 20, 2020, at 1:28 PM, Anna Schumaker <schumaker.anna@gmail.com>
> > wrote:
> > 
> > On Thu, 2020-02-20 at 09:55 -0500, Chuck Lever wrote:
> > > > On Feb 20, 2020, at 9:42 AM, Anna Schumaker <schumaker.anna@gmail.com>
> > > > wrote:
> > > > 
> > > > On Fri, 2020-02-14 at 17:28 -0500, Chuck Lever wrote:
> > > > > > On Feb 14, 2020, at 4:12 PM, schumaker.anna@gmail.com wrote:
> > > > > > 
> > > > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > > > 
> > > > > > This patch adds client support for decoding a single
> > > > > > NFS4_CONTENT_DATA
> > > > > > segment returned by the server. This is the simplest implementation
> > > > > > possible, since it does not account for any hole segments in the
> > > > > > reply.
> > > > > > 
> > > > > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > > > ---
> > > > > > fs/nfs/nfs42xdr.c         | 138
> > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > fs/nfs/nfs4proc.c         |  43 +++++++++++-
> > > > > > fs/nfs/nfs4xdr.c          |   1 +
> > > > > > include/linux/nfs4.h      |   2 +-
> > > > > > include/linux/nfs_fs_sb.h |   1 +
> > > > > > include/linux/nfs_xdr.h   |   2 +-
> > > > > > 6 files changed, 182 insertions(+), 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > > > index c03f3246d6c5..bf118ecabe2c 100644
> > > > > > --- a/fs/nfs/nfs42xdr.c
> > > > > > +++ b/fs/nfs/nfs42xdr.c
> > > > > > @@ -45,6 +45,15 @@
> > > > > > #define encode_deallocate_maxsz		(op_encode_hdr_maxsz + \
> > > > > > 					encode_fallocate_maxsz)
> > > > > > #define decode_deallocate_maxsz		(op_decode_hdr_maxsz)
> > > > > > +#define encode_read_plus_maxsz		(op_encode_hdr_maxsz + \
> > > > > > +					encode_stateid_maxsz + 3)
> > > > > > +#define NFS42_READ_PLUS_SEGMENT_SIZE	(1 /* data_content4 */ +
> > > > > > \
> > > > > > +					 2 /* data_info4.di_offset */ +
> > > > > > \
> > > > > > +					 2 /* data_info4.di_length */)
> > > > > > +#define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
> > > > > > +					 1 /* rpr_eof */ + \
> > > > > > +					 1 /* rpr_contents count */ + \
> > > > > > +					NFS42_READ_PLUS_SEGMENT_SIZE)
> > > > > > #define encode_seek_maxsz		(op_encode_hdr_maxsz + \
> > > > > > 					encode_stateid_maxsz + \
> > > > > > 					 2 /* offset */ + \
> > > > > > @@ -128,6 +137,14 @@
> > > > > > 					decode_putfh_maxsz + \
> > > > > > 					decode_deallocate_maxsz + \
> > > > > > 					decode_getattr_maxsz)
> > > > > > +#define NFS4_enc_read_plus_sz		(compound_encode_hdr_max
> > > > > > sz + \
> > > > > > +					encode_sequence_maxsz + \
> > > > > > +					encode_putfh_maxsz + \
> > > > > > +					encode_read_plus_maxsz)
> > > > > > +#define NFS4_dec_read_plus_sz		(compound_decode_hdr_max
> > > > > > sz + \
> > > > > > +					decode_sequence_maxsz + \
> > > > > > +					decode_putfh_maxsz + \
> > > > > > +					decode_read_plus_maxsz)
> > > > > > #define NFS4_enc_seek_sz		(compound_encode_hdr_maxsz + \
> > > > > > 					encode_sequence_maxsz + \
> > > > > > 					encode_putfh_maxsz + \
> > > > > > @@ -252,6 +269,16 @@ static void encode_deallocate(struct xdr_stream
> > > > > > *xdr,
> > > > > > 	encode_fallocate(xdr, args);
> > > > > > }
> > > > > > 
> > > > > > +static void encode_read_plus(struct xdr_stream *xdr,
> > > > > > +			     const struct nfs_pgio_args *args,
> > > > > > +			     struct compound_hdr *hdr)
> > > > > > +{
> > > > > > +	encode_op_hdr(xdr, OP_READ_PLUS, decode_read_plus_maxsz, hdr);
> > > > > > +	encode_nfs4_stateid(xdr, &args->stateid);
> > > > > > +	encode_uint64(xdr, args->offset);
> > > > > > +	encode_uint32(xdr, args->count);
> > > > > > +}
> > > > > > +
> > > > > > static void encode_seek(struct xdr_stream *xdr,
> > > > > > 			const struct nfs42_seek_args *args,
> > > > > > 			struct compound_hdr *hdr)
> > > > > > @@ -446,6 +473,29 @@ static void nfs4_xdr_enc_deallocate(struct
> > > > > > rpc_rqst
> > > > > > *req,
> > > > > > 	encode_nops(&hdr);
> > > > > > }
> > > > > > 
> > > > > > +/*
> > > > > > + * Encode READ_PLUS request
> > > > > > + */
> > > > > > +static void nfs4_xdr_enc_read_plus(struct rpc_rqst *req,
> > > > > > +				   struct xdr_stream *xdr,
> > > > > > +				   const void *data)
> > > > > > +{
> > > > > > +	const struct nfs_pgio_args *args = data;
> > > > > > +	struct compound_hdr hdr = {
> > > > > > +		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
> > > > > > +	};
> > > > > > +
> > > > > > +	encode_compound_hdr(xdr, req, &hdr);
> > > > > > +	encode_sequence(xdr, &args->seq_args, &hdr);
> > > > > > +	encode_putfh(xdr, args->fh, &hdr);
> > > > > > +	encode_read_plus(xdr, args, &hdr);
> > > > > > +
> > > > > > +	rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> > > > > > +				args->count, hdr.replen);
> > > > > > +	req->rq_rcv_buf.flags |= XDRBUF_READ;
> > > > > 
> > > > > IMO this line is incorrect.
> > > > 
> > > > You're right, this line causes problems for RDMA with READ_PLUS. I added
> > > > it
> > > > to
> > > > match how the other xdr read encoders were set up
> > > 
> > > Ja, I think just removing that line should be sufficient.
> > > Better would be replacing it with a comment explaining
> > > why this encoder does not set XDRBUF_READ. :-)
> > > 
> > > 
> > > > > RFC 8267 Section 6.1 does not list any part of the result of READ_PLUS
> > > > > as DDP-eligible. There's no way for a client to know how to set up
> > > > > Write chunks, unless it knows exactly where the file's holes are in
> > > > > advance. Even then... racy.
> > > > > 
> > > > > Just curious, have you tried READ_PLUS with proto=rdma ?
> > > > 
> > > > I haven't done in-depth performance testing, but I have been able to run
> > > > it.
> > > 
> > > We should figure out whether that will have a regressive
> > > impact on NFS/RDMA workloads. I expect that it will, but
> > > the client can always set up the Reply chunk so that the
> > > READ payload fits precisely in an RDMA segment that lines
> > > up with page cache pages. That mitigates some impact.
> > > 
> > > If your patch set already changes NFSv4.2 mounts to always
> > > use READ_PLUS in place of READ, it might be prudent for the
> > > "proto=rdma" mount option to also set "noreadplus", at least
> > > for the time being.
> > 
> > I can make this change.
> > 
> > > The down-side here is that would make NFSv4.2 on RDMA
> > > unable to recognize holes in files the same way as it
> > > does on TCP, and that's a pretty significant variation
> > > in behavior. Does "noreadplus" even deal with that?
> > 
> > Setting "noreadplus" just causes the client to use the READ operation
> > instead,
> > so there should be no difference between v4.1 and v4.2 if the option is set.
> 
> My concern is the difference between NFSv4.2 with noreadplus
> and NFSv4.2 with readplus. The former is not able to detect
> holes in files on the server, but the latter is.

The client could still use lseek to detect holes. The client throws away the
hole information after xdr decoding, and zeroes out the corresponding pages for
the page cache.

> 
> Is that worth mentioning in the man page, or in release notes
> when NFSv4.2 becomes the default?
> 
> 
> > Anna
> > 
> > > 
> > > > Anna
> > > > 
> > > > > > +	encode_nops(&hdr);
> > > > > > +}
> > > > > > +
> > > > > > /*
> > > > > > * Encode SEEK request
> > > > > > */
> > > > > > @@ -694,6 +744,67 @@ static int decode_deallocate(struct xdr_stream
> > > > > > *xdr,
> > > > > > struct nfs42_falloc_res *re
> > > > > > 	return decode_op_hdr(xdr, OP_DEALLOCATE);
> > > > > > }
> > > > > > 
> > > > > > +static uint32_t decode_read_plus_data(struct xdr_stream *xdr,
> > > > > > struct
> > > > > > nfs_pgio_res *res,
> > > > > > +				      uint32_t *eof)
> > > > > > +{
> > > > > > +	__be32 *p;
> > > > > > +	uint32_t count, recvd;
> > > > > > +	uint64_t offset;
> > > > > > +
> > > > > > +	p = xdr_inline_decode(xdr, 8 + 4);
> > > > > > +	if (unlikely(!p))
> > > > > > +		return -EIO;
> > > > > > +
> > > > > > +	p = xdr_decode_hyper(p, &offset);
> > > > > > +	count = be32_to_cpup(p);
> > > > > > +	if (count == 0)
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	recvd = xdr_read_pages(xdr, count);
> > > > > > +	if (count > recvd) {
> > > > > > +		dprintk("NFS: server cheating in read reply: "
> > > > > > +				"count %u > recvd %u\n", count, recvd);
> > > > > > +		count = recvd;
> > > > > > +		*eof = 0;
> > > > > > +	}
> > > > > > +
> > > > > > +	return count;
> > > > > > +}
> > > > > > +
> > > > > > +static int decode_read_plus(struct xdr_stream *xdr, struct
> > > > > > nfs_pgio_res
> > > > > > *res)
> > > > > > +{
> > > > > > +	__be32 *p;
> > > > > > +	uint32_t count, eof, segments, type;
> > > > > > +	int status;
> > > > > > +
> > > > > > +	status = decode_op_hdr(xdr, OP_READ_PLUS);
> > > > > > +	if (status)
> > > > > > +		return status;
> > > > > > +
> > > > > > +	p = xdr_inline_decode(xdr, 4 + 4);
> > > > > > +	if (unlikely(!p))
> > > > > > +		return -EIO;
> > > > > > +
> > > > > > +	eof = be32_to_cpup(p++);
> > > > > > +	segments = be32_to_cpup(p++);
> > > > > > +	if (segments == 0)
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	p = xdr_inline_decode(xdr, 4);
> > > > > > +	if (unlikely(!p))
> > > > > > +		return -EIO;
> > > > > > +
> > > > > > +	type = be32_to_cpup(p++);
> > > > > > +	if (type == NFS4_CONTENT_DATA)
> > > > > > +		count = decode_read_plus_data(xdr, res, &eof);
> > > > > > +	else
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	res->eof = eof;
> > > > > > +	res->count = count;
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > static int decode_seek(struct xdr_stream *xdr, struct nfs42_seek_res
> > > > > > *res)
> > > > > > {
> > > > > > 	int status;
> > > > > > @@ -870,6 +981,33 @@ static int nfs4_xdr_dec_deallocate(struct
> > > > > > rpc_rqst
> > > > > > *rqstp,
> > > > > > 	return status;
> > > > > > }
> > > > > > 
> > > > > > +/*
> > > > > > + * Decode READ_PLUS request
> > > > > > + */
> > > > > > +static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
> > > > > > +				  struct xdr_stream *xdr,
> > > > > > +				  void *data)
> > > > > > +{
> > > > > > +	struct nfs_pgio_res *res = data;
> > > > > > +	struct compound_hdr hdr;
> > > > > > +	int status;
> > > > > > +
> > > > > > +	status = decode_compound_hdr(xdr, &hdr);
> > > > > > +	if (status)
> > > > > > +		goto out;
> > > > > > +	status = decode_sequence(xdr, &res->seq_res, rqstp);
> > > > > > +	if (status)
> > > > > > +		goto out;
> > > > > > +	status = decode_putfh(xdr);
> > > > > > +	if (status)
> > > > > > +		goto out;
> > > > > > +	status = decode_read_plus(xdr, res);
> > > > > > +	if (!status)
> > > > > > +		status = res->count;
> > > > > > +out:
> > > > > > +	return status;
> > > > > > +}
> > > > > > +
> > > > > > /*
> > > > > > * Decode SEEK request
> > > > > > */
> > > > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > > > index 95d07a3dc5d1..ed3ec8c36273 100644
> > > > > > --- a/fs/nfs/nfs4proc.c
> > > > > > +++ b/fs/nfs/nfs4proc.c
> > > > > > @@ -69,6 +69,10 @@
> > > > > > 
> > > > > > #include "nfs4trace.h"
> > > > > > 
> > > > > > +#ifdef CONFIG_NFS_V4_2
> > > > > > +#include "nfs42.h"
> > > > > > +#endif /* CONFIG_NFS_V4_2 */
> > > > > > +
> > > > > > #define NFSDBG_FACILITY		NFSDBG_PROC
> > > > > > 
> > > > > > #define NFS4_BITMASK_SZ		3
> > > > > > @@ -5199,28 +5203,60 @@ static bool nfs4_read_stateid_changed(struct
> > > > > > rpc_task *task,
> > > > > > 	return true;
> > > > > > }
> > > > > > 
> > > > > > +static bool nfs4_read_plus_not_supported(struct rpc_task *task,
> > > > > > +					struct nfs_pgio_header *hdr)
> > > > > > +{
> > > > > > +	struct nfs_server *server = NFS_SERVER(hdr->inode);
> > > > > > +	struct rpc_message *msg = &task->tk_msg;
> > > > > > +
> > > > > > +	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS]
> > > > > > &&
> > > > > > +	    server->caps & NFS_CAP_READ_PLUS && task->tk_status ==
> > > > > > -ENOTSUPP) {
> > > > > > +		server->caps &= ~NFS_CAP_READ_PLUS;
> > > > > > +		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
> > > > > > +		rpc_restart_call_prepare(task);
> > > > > > +		return true;
> > > > > > +	}
> > > > > > +	return false;
> > > > > > +}
> > > > > > +
> > > > > > static int nfs4_read_done(struct rpc_task *task, struct
> > > > > > nfs_pgio_header
> > > > > > *hdr)
> > > > > > {
> > > > > > -
> > > > > > 	dprintk("--> %s\n", __func__);
> > > > > > 
> > > > > > 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
> > > > > > 		return -EAGAIN;
> > > > > > 	if (nfs4_read_stateid_changed(task, &hdr->args))
> > > > > > 		return -EAGAIN;
> > > > > > +	if (nfs4_read_plus_not_supported(task, hdr))
> > > > > > +		return -EAGAIN;
> > > > > > 	if (task->tk_status > 0)
> > > > > > 		nfs_invalidate_atime(hdr->inode);
> > > > > > 	return hdr->pgio_done_cb ? hdr->pgio_done_cb(task, hdr) :
> > > > > > 				    nfs4_read_done_cb(task, hdr);
> > > > > > }
> > > > > > 
> > > > > > +#ifdef CONFIG_NFS_V4_2
> > > > > > +static void nfs42_read_plus_support(struct nfs_server *server,
> > > > > > struct
> > > > > > rpc_message *msg)
> > > > > > +{
> > > > > > +	if (server->caps & NFS_CAP_READ_PLUS)
> > > > > > +		msg->rpc_proc =
> > > > > > &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
> > > > > > +	else
> > > > > > +		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
> > > > > > +}
> > > > > > +#else
> > > > > > +static void nfs42_read_plus_support(struct nfs_server *server,
> > > > > > struct
> > > > > > rpc_message *msg)
> > > > > > +{
> > > > > > +	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
> > > > > > +}
> > > > > > +#endif /* CONFIG_NFS_V4_2 */
> > > > > > +
> > > > > > static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
> > > > > > 				 struct rpc_message *msg)
> > > > > > {
> > > > > > 	hdr->timestamp   = jiffies;
> > > > > > 	if (!hdr->pgio_done_cb)
> > > > > > 		hdr->pgio_done_cb = nfs4_read_done_cb;
> > > > > > -	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
> > > > > > +	nfs42_read_plus_support(NFS_SERVER(hdr->inode), msg);
> > > > > > 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0,
> > > > > > 0);
> > > > > > }
> > > > > > 
> > > > > > @@ -9970,7 +10006,8 @@ static const struct nfs4_minor_version_ops
> > > > > > nfs_v4_2_minor_ops = {
> > > > > > 		| NFS_CAP_SEEK
> > > > > > 		| NFS_CAP_LAYOUTSTATS
> > > > > > 		| NFS_CAP_CLONE
> > > > > > -		| NFS_CAP_LAYOUTERROR,
> > > > > > +		| NFS_CAP_LAYOUTERROR
> > > > > > +		| NFS_CAP_READ_PLUS,
> > > > > > 	.init_client = nfs41_init_client,
> > > > > > 	.shutdown_client = nfs41_shutdown_client,
> > > > > > 	.match_stateid = nfs41_match_stateid,
> > > > > > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > > > > > index 47817ef0aadb..68b2917d0537 100644
> > > > > > --- a/fs/nfs/nfs4xdr.c
> > > > > > +++ b/fs/nfs/nfs4xdr.c
> > > > > > @@ -7584,6 +7584,7 @@ const struct rpc_procinfo nfs4_procedures[] =
> > > > > > {
> > > > > > 	PROC42(COPY_NOTIFY,	enc_copy_notify,	dec_copy_notify)
> > > > > > ,
> > > > > > 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp)
> > > > > > ,
> > > > > > 	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror)
> > > > > > ,
> > > > > > +	PROC42(READ_PLUS,	enc_read_plus,		dec_read_plus),
> > > > > > };
> > > > > > 
> > > > > > static unsigned int
> > > > > > nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
> > > > > > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > > > > > index 82d8fb422092..c1eeef52545c 100644
> > > > > > --- a/include/linux/nfs4.h
> > > > > > +++ b/include/linux/nfs4.h
> > > > > > @@ -540,8 +540,8 @@ enum {
> > > > > > 
> > > > > > 	NFSPROC4_CLNT_LOOKUPP,
> > > > > > 	NFSPROC4_CLNT_LAYOUTERROR,
> > > > > > -
> > > > > > 	NFSPROC4_CLNT_COPY_NOTIFY,
> > > > > > +	NFSPROC4_CLNT_READ_PLUS,
> > > > > > };
> > > > > > 
> > > > > > /* nfs41 types */
> > > > > > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > > > > > index 465fa98258a3..11248c5a7b24 100644
> > > > > > --- a/include/linux/nfs_fs_sb.h
> > > > > > +++ b/include/linux/nfs_fs_sb.h
> > > > > > @@ -281,5 +281,6 @@ struct nfs_server {
> > > > > > #define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
> > > > > > #define NFS_CAP_LAYOUTERROR	(1U << 26)
> > > > > > #define NFS_CAP_COPY_NOTIFY	(1U << 27)
> > > > > > +#define NFS_CAP_READ_PLUS	(1U << 28)
> > > > > > 
> > > > > > #endif
> > > > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > > > > index 94c77ed55ce1..8efbf3d8b263 100644
> > > > > > --- a/include/linux/nfs_xdr.h
> > > > > > +++ b/include/linux/nfs_xdr.h
> > > > > > @@ -655,7 +655,7 @@ struct nfs_pgio_args {
> > > > > > struct nfs_pgio_res {
> > > > > > 	struct nfs4_sequence_res	seq_res;
> > > > > > 	struct nfs_fattr *	fattr;
> > > > > > -	__u32			count;
> > > > > > +	__u64			count;
> > > > > > 	__u32			op_status;
> > > > > > 	union {
> > > > > > 		struct {
> > > > > > -- 
> > > > > > 2.25.0
> > > > > > 
> > > > > 
> > > > > --
> > > > > Chuck Lever
> > > 
> > > --
> > > Chuck Lever
> 
> --
> Chuck Lever
> 
> 
> 

