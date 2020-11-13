Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4932B2595
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 21:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgKMUei (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 15:34:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40432 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKMUei (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 15:34:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADKTPIn177452;
        Fri, 13 Nov 2020 20:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=urY23VoAYPb/imbnqfqu1GYfVi2+4761dlV1t42mktw=;
 b=RpHVw+fxEfWuheq4PUCp3OkyH5dxpUp3dzXkrsQblScMzRHqyFnlBeKV9VrsN4HnqZ7Y
 +Yr54oZL8m9kfyDLjx2IK4PUtROu+qOnJYWFfn8sjDwNC5oEXYyDgGxbn7ShbxFizlYS
 59AIY6N7rVaDwPq7zN5uqRH/zPAVzBXpih6hkQOtAIHhM06kSCJp2axkjRT/4IGzPa1d
 a3jgo+r/yZ40lWAqKnK4e0ndQ8wxIK32u4x2cbbFyx+snw/Y9ZEi5NXwG3TRf+4OOowR
 nNuqHPBVqRzO7+hl8g5zPv0EKOty/Othw0SRizW4gL/qOXgeQSzRmR/8VLZ1gTk0ULAT 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72f2cdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 20:34:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADKUJDW162704;
        Fri, 13 Nov 2020 20:34:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34rtku874g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 20:34:31 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ADKYRNh019698;
        Fri, 13 Nov 2020 20:34:27 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 12:34:27 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
Date:   Fri, 13 Nov 2020 15:34:25 -0500
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Frank van der Linden <fllinden@amazon.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga-

> On Nov 13, 2020, at 2:08 PM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> xfstest generic/013 over on a NFSoRDMA over SoftRoCE or iWarp panics
> and running with KASAN reports:

There is still only a highly circumstantial connection between
soft RoCE and iWarp and these crashes, so this description seems
misleading and/or pre-mature.


> [  216.018711] BUG: KASAN: wild-memory-access in =
rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> [  216.024195] Write of size 12 at addr 0005088000000000 by task =
kworker/1:1H/480
> [  216.028820]
> [  216.029776] CPU: 1 PID: 480 Comm: kworker/1:1H Not tainted =
5.8.0-rc5+ #37
> [  216.034247] Hardware name: VMware, Inc. VMware Virtual =
Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> [  216.040604] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [  216.043739] Call Trace:
> [  216.045014]  dump_stack+0x7c/0xb0
> [  216.046757]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> [  216.050008]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> [  216.053091]  kasan_report.cold.10+0x6a/0x85
> [  216.055703]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> [  216.058979]  check_memory_region+0x183/0x1e0
> [  216.061933]  memcpy+0x38/0x60
> [  216.064077]  rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> [  216.067502]  ? rpcrdma_reset_cwnd+0x70/0x70 [rpcrdma]
> [  216.070268]  ? recalibrate_cpu_khz+0x10/0x10
> [  216.072585]  ? rpcrdma_reply_handler+0x604/0x6e0 [rpcrdma]
> [  216.075469]  __ib_process_cq+0xa7/0x220 [ib_core]
> [  216.078077]  ib_cq_poll_work+0x31/0xb0 [ib_core]
> [  216.080451]  process_one_work+0x387/0x6c0
> [  216.082498]  worker_thread+0x57/0x5a0
> [  216.084425]  ? process_one_work+0x6c0/0x6c0
> [  216.086583]  kthread+0x1ca/0x200
> [  216.088775]  ? kthread_create_on_node+0xc0/0xc0
> [  216.091847]  ret_from_fork+0x22/0x30
>=20
> Fixes: 6c2190b3fcbc ("NFS: Fix listxattr receive buffer size")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/nfs42xdr.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 6e060a8..e88bc7a 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -196,7 +196,8 @@
> 				 1 + nfs4_xattr_name_maxsz + 1)
> #define decode_setxattr_maxsz   (op_decode_hdr_maxsz + =
decode_change_info_maxsz)
> #define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
> -#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + =
1)
> +#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + \
> +				  XDR_QUADLEN(NFS4_OPAQUE_LIMIT))

=46rom RFC 8276, Section 8.4.3.2:

   /// struct LISTXATTRS4resok {
   ///         nfs_cookie4    lxr_cookie;
   ///         xattrkey4      lxr_names<>;
   ///         bool           lxr_eof;
   /// };

The decode_listxattrs_maxsz macro defines the maximum size of
the /fixed portion/ of the LISTXATTRS reply. That is the operation
status code, the cookie, and the EOF flag. maxsz has an extra
"+ 1" for rpc_prepare_reply_pages() to deal with possible XDR
padding. The post-6c2190b3fcbc value of this macro is already
correct, and removing the "+ 1" is wrong.

In addition, the variable portion of the result is an unbounded
array of component4 fields, nothing to do with NFS4_OPAQUE_LIMIT,
so that's just an arbitrary constant here with no justification.

Adding more space to the receive buffer happens to help the case
where there are no xattrs to list. That doesn't mean its the
correct solution in general. It certainly won't be sufficient to
handle an xattr name array that is larger than 1024 bytes.


The client manages the variable portion of that result in the
reply's pages array, which is set up by nfs4_xdr_enc_listxattrs().

Further:

> rpcrdma_complete_rqst+0x447

is in the paragraph of rpcrdma_inline_fixup() that copies received
bytes into the receive xdr_buf's pages array.

The address "0005088000000000" is bogus. Since
nfs4_xdr_enc_listxattrs() sets XDRBUF_SPARSE_PAGES, it's likely
it is relying on the transport to allocate pages for this buffer,
and possibly that page allocation has failed or has a bug.

Please determine why the encode side has not set up the correct
number of pages to handle the LISTXATTRS result. Until then I
have to NACK this one.


> #define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
> 				  nfs4_xattr_name_maxsz)
> #define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
> --=20
> 1.8.3.1

--
Chuck Lever



