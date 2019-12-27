Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA112BAB4
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2019 20:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfL0THO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Dec 2019 14:07:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45074 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfL0THO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Dec 2019 14:07:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so26871921wrj.12;
        Fri, 27 Dec 2019 11:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=tniVG08pDbtt/U/HOE0PLDSZkuB9hUWmqP2hbBgwEr8=;
        b=XMFNug5Ni737RFKBPy4+89fGFQxC7DOWC3+PYsA9x3PVaFFSmAVbc38bCUKWJZYaq3
         mpUJiajvq34KSFdv5zBYoBMbLLy5ocOUwpCj8njtsJPmJRHq4TNeVQIdBZkT5SUKHTWp
         PhIhi8zGFYKV4KkT4wKVgewMnXPUTB4BaNXB6w1hKLT9twYUQtx5sJdjsPmEYTkFDMWf
         z5KfvhqlqT/CYA5Ea17kqj3FEDhR4gRDMfqjKXAcKubO+7Ve2gKAWQYRMyV56SC8W18c
         ojElH9ZRLOcx2W1GWke8zlXbUgL0T+pgQaMA0umylECr1/Q9wLsk6N1ZXeiZyxf6kbZU
         P+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=tniVG08pDbtt/U/HOE0PLDSZkuB9hUWmqP2hbBgwEr8=;
        b=JVTZWix0gzqDmZQFmfSFNLPErWEkBdAgkC5pw6JuA7gc5HL4MvWhxQJBsbvNtbi0lm
         toxhetG54kqN00s4P+ReHlB2Xm4X8uAukT74qiZqAFYJ2VFxupk18jPK2GnJKKrRs4cw
         yuhdb2jAIQ/XHx7wTI8wGd4Bqui/HATDrplb74NoEPoPnUa5gX1GvB3493vtz7ItofLI
         HCaNE09DE965Y9UlCg1GFyWJJfOzZAbD4a0Rp9EM1k8XsbPpKeDvm2nNQbsngJH4q4yR
         gLLgChyGLKcWCmmRK08LzA6SfXT45jxOTedbOm1tc/p0bBRxusnXtLo9ROiG1pJniH9i
         ziOQ==
X-Gm-Message-State: APjAAAVzyZVXKeAE3ngpoOm0sH/xek3UFMgZsUqoi60Kvb12HBN2rti+
        fEoF9AaZZIAzNVRMYiWfd8pJvb8GFlByMA==
X-Google-Smtp-Source: APXvYqx8Urh8DNVD37KtNbHJvD1fqK294Ao7VNGl4WnF9uQlUgqO606vDIXeEvtwOl/I23zFp78Etw==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr50234771wra.36.1577473630697;
        Fri, 27 Dec 2019 11:07:10 -0800 (PST)
Received: from loulrmilkow1 (227.46-29-148.tkchopin.pl. [46.29.148.227])
        by smtp.gmail.com with ESMTPSA id e18sm35307067wrr.95.2019.12.27.11.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 11:07:09 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     "'Chuck Lever'" <chuck.lever@oracle.com>
Cc:     "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
        "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>
References: <001901d5ba67$8954ede0$9bfec9a0$@gmail.com> <594E0E04-1253-4C0D-8A58-EB4AF883B7EC@oracle.com>
In-Reply-To: <594E0E04-1253-4C0D-8A58-EB4AF883B7EC@oracle.com>
Subject: RE: [PATCH v2] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
Date:   Fri, 27 Dec 2019 19:07:06 -0000
Message-ID: <015901d5bce8$d6957010$83c05030$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFtSHQznciB4gB7iYqNNX8PSbx2NgLYPe2PqIfWcRA=
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

> > On Dec 24, 2019, at 9:36 AM, Robert Milkowski <rmilkowski@gmail.com> wrote:
> >
> > From: Robert Milkowski <rmilkowski@gmail.com>
> >
> > Currently, each time nfs4_do_fsinfo() is called it will do an implicit
> > NFS4 lease renewal, which is not compliant with the NFS4 specification.
> > This can result in a lease being expired by an NFS server.
> 
> In addition to stating the bug symptoms, IMO you need
> 
> Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> 

Right, makes sense. I will include it in the next patch revision.
Thans.


> And this description needs to explain how 83ca7f5ab31f broke things.

Is adding the below to the previous description enough?

The 83ca7f5ab31f introduced implicit renew operation when calling nfs4_do_fsinfo(),
which is not done by NFS servers which under some circumstances results in nfsv4.0 lease
to expire on a server side which then will return NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.
This can be easily reproduced by frequently unmounting a sub-mount over nfsv4.0,
which after a grace period will result in an error returned by a server when accessing a file.
This can also happen after a sub-mount is automatically unmounted due to inactivity
(after nfs_mountpoint_expiry_timeout), then the sub-mount is stat'ed causing it to be mounted again,
and a file is accessed shortly after (this all depends on specific grace time, last RENEW, etc.).
This specific case was observed on a production systems. 


> 
> There are two usual practices to introduce behavior that diverges
> amongst NFSv4 minor versions. Neither practice is followed here.
> 
> - The difference is added to the XDR encoder and decoder. You could
> do that by adding a RENEW to the COMPOUND in the NFSv4.0 case.
> 
> - The function is converted to a virtual function which is added to
> struct nfs4_minor_version_ops.
> 

Thanks for the explanation, I'm learning here and really do appreciate any help.
So given the above advise I ended up with the below:


diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..6d075f0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4998,12 +4998,16 @@ static int nfs4_proc_statfs(struct nfs_server *server, struct nfs_fh *fhandle, s
 static int _nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh *fhandle,
                struct nfs_fsinfo *fsinfo)
 {
+       struct nfs_client *clp = server->nfs_client;
        struct nfs4_fsinfo_arg args = {
                .fh = fhandle,
                .bitmask = server->attr_bitmask,
+               .clientid = clp->cl_clientid,
+               .renew = nfs4_has_session(clp) ? 0 : 1,         /* append RENEW */
        };
        struct nfs4_fsinfo_res res = {
                .fsinfo = fsinfo,
+               .renew = nfs4_has_session(clp) ? 0 : 1,
        };
        struct rpc_message msg = {
                .rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_FSINFO],
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 936c577..0ce9a10 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -555,11 +555,13 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define NFS4_enc_fsinfo_sz     (compound_encode_hdr_maxsz + \
                                encode_sequence_maxsz + \
                                encode_putfh_maxsz + \
-                               encode_fsinfo_maxsz)
+                               encode_fsinfo_maxsz + \
+                               encode_renew_maxsz)
 #define NFS4_dec_fsinfo_sz     (compound_decode_hdr_maxsz + \
                                decode_sequence_maxsz + \
                                decode_putfh_maxsz + \
-                               decode_fsinfo_maxsz)
+                               decode_fsinfo_maxsz + \
+                               decode_renew_maxsz)
 #define NFS4_enc_renew_sz      (compound_encode_hdr_maxsz + \
                                encode_renew_maxsz)
 #define NFS4_dec_renew_sz      (compound_decode_hdr_maxsz + \
@@ -2646,6 +2648,8 @@ static void nfs4_xdr_enc_fsinfo(struct rpc_rqst *req, struct xdr_stream *xdr,
        encode_sequence(xdr, &args->seq_args, &hdr);
        encode_putfh(xdr, args->fh, &hdr);
        encode_fsinfo(xdr, args->bitmask, &hdr);
+       if (args->renew)
+               encode_renew(xdr, args->clientid, &hdr);
        encode_nops(&hdr);
 }

@@ -6778,6 +6782,11 @@ static int nfs4_xdr_dec_fsinfo(struct rpc_rqst *req, struct xdr_stream *xdr,
                status = decode_putfh(xdr);
        if (!status)
                status = decode_fsinfo(xdr, res->fsinfo);
+       if (status)
+               goto out;
+       if (res->renew)
+               status = decode_renew(xdr);
+out:
        return status;
 }


diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 72d5695..49bd673 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1025,11 +1025,14 @@ struct nfs4_fsinfo_arg {
        struct nfs4_sequence_args       seq_args;
        const struct nfs_fh *           fh;
        const u32 *                     bitmask;
+       clientid4                       clientid;
+       unsigned char                   renew:1;
 };

 struct nfs4_fsinfo_res {
        struct nfs4_sequence_res        seq_res;
        struct nfs_fsinfo              *fsinfo;
+       unsigned char                   renew:1;
 };

 struct nfs4_getattr_arg {



Let me know if that's what you had it mind and if no further comments I will finish testing and submit new patch.


> Prior to 83ca7f5ab31f, IIRC this function was part of a code path
> that did actually renew the lease. It seems to me that the proper
> fix here is to make NFSv4.0 renew the lease, not the other way
> around. Is there a reason not to add a RENEW to the NFSv4.0 version
> of the fsinfo COMPOUND?
> 

Strictly speaking I don't think renew is required here, but adding it as part of the compound
operation is harmless and more in-line with how it is currently done for v4.1.

Also, before the 83ca7f5ab31f, implicit lease renewal was only done in nfs4_proc_setclientid_confirm(),
but the function is not called when mounting a sub-mount, and it was not done in nfs4_do_fsinfo() either.
The implicit renewal in nfs4_do_fsinfo() when mounting each submount was introduced by the commit, before it only happened on root
mount.
So this particular issue I'm trying to fix here did not occur before the change, I think.

(btw: according to RFC7530 section 9.5. the implicit renewal in setclientid_confirm() wasn't correct either but I think it was
harmless).




