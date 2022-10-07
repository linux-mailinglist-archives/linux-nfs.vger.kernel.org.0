Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED305F8161
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Oct 2022 01:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGXyO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Oct 2022 19:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJGXyN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Oct 2022 19:54:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B1F51417
        for <linux-nfs@vger.kernel.org>; Fri,  7 Oct 2022 16:54:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h10so5867413plb.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Oct 2022 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFpW66GeS3YUx2lMHwEmNhRNM6pB5r4KJHPflnVAnKI=;
        b=JoCEIXGUUJDf4x+Q3o/mb87ECYIYsnoWagCvFgsb0daNZ0WrAg8k/CA1F/uGppRdOR
         7VgOqAddOrtcY3APKD7jfpYNAehJgc0FLLJAoaK8xuKYyBMN+gxaSPHhfxKz1pyj+w+u
         mtQLR0aTN2pueJ2AYvYA47Y61GXoKxBmyS8JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFpW66GeS3YUx2lMHwEmNhRNM6pB5r4KJHPflnVAnKI=;
        b=Y+kQcmIDW5l85ciu8PSCabcgWlX+i9P9aAZ1UTJaPcaX+OxrG1iM2ZyXwjNHncRttm
         kiQz+D7l0+ubUmejnk347GxltfdIn5qI5tkvvmoVYBzK94Nlg8kpjby2fE5WreAzTIO3
         wGWtNexeUlnxfp9M9kIj/O38cfAlCvlDDR644MP8pFoTjSVn/ETFCu5UaM35LJYV4egl
         mPwk8b4w4XIXMBTZbp2nMT2f4bkxC0PJLPU8jON6f2tuffulCTrNXsg46gehkpAXeUd/
         oLtxWuqHw4OHlNR1yKobaLhu+YiWfU40u0hV63aUbJYaeSsIx8nLAUYRLduwPvbplYjA
         kNKg==
X-Gm-Message-State: ACrzQf1sMXMEvK63EhA3Kh0QoGueBrtXFqbf0WTbp+jMEfsiuZXHvTnS
        XLgKhokDqzk858rHpQU+VV8poQ==
X-Google-Smtp-Source: AMsMyM5fuk6iZ1wy23PajiFOrez+SdOU3DU90bUG6Klpj33+MaQFyZXaD4GZ9N1Yi2+901a7XoRveg==
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id w20-20020a170902d71400b0017f58131df4mr7694588ply.148.1665186849530;
        Fri, 07 Oct 2022 16:54:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g26-20020aa796ba000000b0056188850950sm2193789pfk.180.2022.10.07.16.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 16:54:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-nfs@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] NFSD: Avoid clashing function prototypes
Date:   Fri,  7 Oct 2022 16:54:06 -0700
Message-Id: <20221007235406.2951724-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=53753; h=from:subject; bh=HwzXwrWtHcE/2aY+XiDT4nBd2b/0xXXu15uVvqY4rLQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjQLwdZ7Zy7DayyJ6DgPIloYWTQas1hWmxixeYkFgQ pT88w8yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0C8HQAKCRCJcvTf3G3AJsLZEA CjyGThyFvlCjtaqDVQFI46XBmm2A53QHXxaAlK0/ItxBCveS4pkRcB+sJ549R1goweuxk2x3pvZP1b DCkhmfXIhItNJqjxaIx7GK+Nd7uSWdReM6fyVgfT7BQpd8jciW6FHU9IPgpyF8b2adloRB66lTjLiA +DANTI/qBNQaqv+S9eGDnc8a4gHPR2jqP4xLZifXkjzTCgE6/k9cOvn2dpiSxQuSxJ7GAPUPWQasdf PpNc84ZyTMNe0Kf1q3yVpDgx8uobIGSqvHj5xJOKOl3cF+uorxFWTBWlAv52xeTTzTp9SWe6+Z7LFU ZpgHB9d20mzJTiypJwiicoVep3g+Y9nYE/ZfAVQYzknw1VpWE5xSkbYwUvwuZtmaAJbtjNpqjvvNpf LtrA55LKyAabua0wcdAfsigxVAZhv+jlTuID5Rp3oLMb6gC4bgt30DdWKtIEExn+d3SN0dXmj3wf1e hzqBNozjRi6V2n2oJIHimDbNarS3kR9+3YekUsTh136ojinhnlSFPRK+PP91xs/8dopPLvAjOc23RI XAvp77OZajNxygG2uCjJFgKb1DMpOb8yvCmy26Y1ebRhtKhpi4dAHb7x4VJWq7Tk8U2F4ogVWj/Fll picj2WtnG7C0EnbP2cd+G1alP4f02vW5XeE77CmERcqvX93ZHsx8LPo26Mzw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When built with Control Flow Integrity, function prototypes between
caller and function declaration must match. These mismatches are visible
at compile time with the new -Wcast-function-type-strict in Clang[1].

There were 97 warnings produced by NFS. For example:

fs/nfsd/nfs4xdr.c:2228:17: warning: cast from '__be32 (*)(struct nfsd4_compoundargs *, struct nfsd4_access *)' (aka 'unsigned int (*)(struct nfsd4_compoundargs *, struct nfsd4_access *)') to 'nfsd4_dec' (aka 'unsigned int (*)(struct nfsd4_compoundargs *, void *)') converts to incompatible function type [-Wcast-function-type-strict]
        [OP_ACCESS]             = (nfsd4_dec)nfsd4_decode_access,
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The enc/dec callbacks were defined as passing "void *" as the second
argument, but were being implicitly cast to a new type. Replace the
argument with a variable the desired to perform the casting in the
function body. There are no resulting binary differences.

Changes were made mechanically using the following Coccinelle script:

@cast@
identifier func;
type T, opsT;
identifier ops, N;
@@

 opsT ops[] = {
	[N] =
-	(T)
	func,
 };

@already_void@
identifier cast.func;
identifier name;
@@

 func(..., void *name)
 {
	...
 }

@proto depends on !already_void@
identifier cast.func;
type T;
identifier name;
@@

 func(...,
-	T name
+	void *_arg
 ) {
+	T name = _arg;
	...
   }

[1] https://reviews.llvm.org/D134831

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/nfsd/nfs4xdr.c | 601 +++++++++++++++++++++++++++-------------------
 1 file changed, 352 insertions(+), 249 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e9690a061ec..df059b03bdf2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -768,16 +768,18 @@ nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 
 static __be32
 nfsd4_decode_access(struct nfsd4_compoundargs *argp,
-		    struct nfsd4_access *access)
+		    void *_arg)
 {
+	struct nfsd4_access *access = _arg;
 	if (xdr_stream_decode_u32(argp->xdr, &access->ac_req_access) < 0)
 		return nfserr_bad_xdr;
 	return nfs_ok;
 }
 
 static __be32
-nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
+nfsd4_decode_close(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_close *close = _arg;
 	if (xdr_stream_decode_u32(argp->xdr, &close->cl_seqid) < 0)
 		return nfserr_bad_xdr;
 	return nfsd4_decode_stateid4(argp, &close->cl_stateid);
@@ -785,8 +787,9 @@ nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 
 
 static __be32
-nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit)
+nfsd4_decode_commit(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_commit *commit = _arg;
 	if (xdr_stream_decode_u64(argp->xdr, &commit->co_offset) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &commit->co_count) < 0)
@@ -795,8 +798,9 @@ nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit
 }
 
 static __be32
-nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create)
+nfsd4_decode_create(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_create *create = _arg;
 	__be32 *p, status;
 
 	if (xdr_stream_decode_u32(argp->xdr, &create->cr_type) < 0)
@@ -840,21 +844,24 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 }
 
 static inline __be32
-nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegreturn *dr)
+nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_delegreturn *dr = _arg;
 	return nfsd4_decode_stateid4(argp, &dr->dr_stateid);
 }
 
 static inline __be32
-nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
+nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_getattr *getattr = _arg;
 	return nfsd4_decode_bitmap4(argp, getattr->ga_bmval,
 				    ARRAY_SIZE(getattr->ga_bmval));
 }
 
 static __be32
-nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
+nfsd4_decode_link(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_link *link = _arg;
 	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
 
@@ -901,8 +908,9 @@ nfsd4_decode_locker4(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 }
 
 static __be32
-nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
+nfsd4_decode_lock(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_lock *lock = _arg;
 	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_type) < 0)
 		return nfserr_bad_xdr;
 	if ((lock->lk_type < NFS4_READ_LT) || (lock->lk_type > NFS4_WRITEW_LT))
@@ -917,8 +925,9 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 }
 
 static __be32
-nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
+nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_lockt *lockt = _arg;
 	if (xdr_stream_decode_u32(argp->xdr, &lockt->lt_type) < 0)
 		return nfserr_bad_xdr;
 	if ((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
@@ -932,8 +941,9 @@ nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 }
 
 static __be32
-nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
+nfsd4_decode_locku(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_locku *locku = _arg;
 	__be32 status;
 
 	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_type) < 0)
@@ -954,8 +964,9 @@ nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 }
 
 static __be32
-nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup)
+nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_lookup *lookup = _arg;
 	return nfsd4_decode_component4(argp, &lookup->lo_name, &lookup->lo_len);
 }
 
@@ -1135,8 +1146,9 @@ nfsd4_decode_open_claim4(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
+nfsd4_decode_open(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_open *open = _arg;
 	__be32 status;
 	u32 dummy;
 
@@ -1166,8 +1178,9 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 }
 
 static __be32
-nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_confirm *open_conf)
+nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_open_confirm *open_conf = _arg;
 	__be32 status;
 
 	if (argp->minorversion >= 1)
@@ -1183,8 +1196,9 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 }
 
 static __be32
-nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_downgrade *open_down)
+nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_open_downgrade *open_down = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &open_down->od_stateid);
@@ -1201,8 +1215,9 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 }
 
 static __be32
-nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
+nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_putfh *putfh = _arg;
 	__be32 *p;
 
 	if (xdr_stream_decode_u32(argp->xdr, &putfh->pf_fhlen) < 0)
@@ -1228,8 +1243,9 @@ nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
 }
 
 static __be32
-nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
+nfsd4_decode_read(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_read *read = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &read->rd_stateid);
@@ -1244,8 +1260,9 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 }
 
 static __be32
-nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *readdir)
+nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_readdir *readdir = _arg;
 	__be32 status;
 
 	if (xdr_stream_decode_u64(argp->xdr, &readdir->rd_cookie) < 0)
@@ -1265,14 +1282,16 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 }
 
 static __be32
-nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove)
+nfsd4_decode_remove(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_remove *remove = _arg;
 	return nfsd4_decode_component4(argp, &remove->rm_name, &remove->rm_namelen);
 }
 
 static __be32
-nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename)
+nfsd4_decode_rename(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_rename *rename = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_component4(argp, &rename->rn_sname, &rename->rn_snamelen);
@@ -1282,21 +1301,24 @@ nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename
 }
 
 static __be32
-nfsd4_decode_renew(struct nfsd4_compoundargs *argp, clientid_t *clientid)
+nfsd4_decode_renew(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	clientid_t *clientid = _arg;
 	return nfsd4_decode_clientid4(argp, clientid);
 }
 
 static __be32
 nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
-		     struct nfsd4_secinfo *secinfo)
+		     void *_arg)
 {
+	struct nfsd4_secinfo *secinfo = _arg;
 	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
 static __be32
-nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *setattr)
+nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_setattr *setattr = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &setattr->sa_stateid);
@@ -1309,8 +1331,9 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 }
 
 static __be32
-nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid *setclientid)
+nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_setclientid *setclientid = _arg;
 	__be32 *p, status;
 
 	if (argp->minorversion >= 1)
@@ -1350,8 +1373,9 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclient
 }
 
 static __be32
-nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid_confirm *scd_c)
+nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_setclientid_confirm *scd_c = _arg;
 	__be32 status;
 
 	if (argp->minorversion >= 1)
@@ -1365,8 +1389,9 @@ nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_s
 
 /* Also used for NVERIFY */
 static __be32
-nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify)
+nfsd4_decode_verify(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_verify *verify = _arg;
 	__be32 *p, status;
 
 	status = nfsd4_decode_bitmap4(argp, verify->ve_bmval,
@@ -1390,8 +1415,9 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 }
 
 static __be32
-nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
+nfsd4_decode_write(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_write *write = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &write->wr_stateid);
@@ -1412,8 +1438,9 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 }
 
 static __be32
-nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_release_lockowner *rlockowner)
+nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_release_lockowner *rlockowner = _arg;
 	__be32 status;
 
 	if (argp->minorversion >= 1)
@@ -1430,15 +1457,19 @@ nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_rel
 	return nfs_ok;
 }
 
-static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
+static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp,
+					   void *_arg)
 {
+	struct nfsd4_backchannel_ctl *bc = _arg;
 	if (xdr_stream_decode_u32(argp->xdr, &bc->bc_cb_program) < 0)
 		return nfserr_bad_xdr;
 	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
 }
 
-static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
+static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
+						void *_arg)
 {
+	struct nfsd4_bind_conn_to_session *bcts = _arg;
 	u32 use_conn_in_rdma_mode;
 	__be32 status;
 
@@ -1579,8 +1610,9 @@ nfsd4_decode_nfs_impl_id4(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
-			 struct nfsd4_exchange_id *exid)
+			 void *_arg)
 {
+	struct nfsd4_exchange_id *exid = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_verifier4(argp, &exid->verifier);
@@ -1631,8 +1663,9 @@ nfsd4_decode_channel_attrs4(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
-			    struct nfsd4_create_session *sess)
+			    void *_arg)
 {
+	struct nfsd4_create_session *sess = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_clientid4(argp, &sess->clientid);
@@ -1659,23 +1692,26 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_destroy_session(struct nfsd4_compoundargs *argp,
-			     struct nfsd4_destroy_session *destroy_session)
+			     void *_arg)
 {
+	struct nfsd4_destroy_session *destroy_session = _arg;
 	return nfsd4_decode_sessionid4(argp, &destroy_session->sessionid);
 }
 
 static __be32
 nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
-			  struct nfsd4_free_stateid *free_stateid)
+			  void *_arg)
 {
+	struct nfsd4_free_stateid *free_stateid = _arg;
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
-		struct nfsd4_getdeviceinfo *gdev)
+		void *_arg)
 {
+	struct nfsd4_getdeviceinfo *gdev = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
@@ -1694,8 +1730,9 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
-			  struct nfsd4_layoutcommit *lcp)
+			  void *_arg)
 {
+	struct nfsd4_layoutcommit *lcp = _arg;
 	__be32 *p, status;
 
 	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.offset) < 0)
@@ -1729,8 +1766,9 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
-		struct nfsd4_layoutget *lgp)
+		void *_arg)
 {
+	struct nfsd4_layoutget *lgp = _arg;
 	__be32 status;
 
 	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_signal) < 0)
@@ -1756,8 +1794,9 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
-		struct nfsd4_layoutreturn *lrp)
+		void *_arg)
 {
+	struct nfsd4_layoutreturn *lrp = _arg;
 	if (xdr_stream_decode_bool(argp->xdr, &lrp->lr_reclaim) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_layout_type) < 0)
@@ -1769,8 +1808,9 @@ nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 #endif /* CONFIG_NFSD_PNFS */
 
 static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
-					   struct nfsd4_secinfo_no_name *sin)
+					   void *_arg)
 {
+	struct nfsd4_secinfo_no_name *sin = _arg;
 	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
 		return nfserr_bad_xdr;
 	return nfs_ok;
@@ -1778,8 +1818,9 @@ static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_sequence *seq)
+		      void *_arg)
 {
+	struct nfsd4_sequence *seq = _arg;
 	__be32 *p, status;
 
 	status = nfsd4_decode_sessionid4(argp, &seq->sessionid);
@@ -1797,8 +1838,9 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_stateid *test_stateid)
+nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_test_stateid *test_stateid = _arg;
 	struct nfsd4_test_stateid_id *stateid;
 	__be32 status;
 	u32 i;
@@ -1822,14 +1864,16 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 }
 
 static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp,
-					    struct nfsd4_destroy_clientid *dc)
+					    void *_arg)
 {
+	struct nfsd4_destroy_clientid *dc = _arg;
 	return nfsd4_decode_clientid4(argp, &dc->clientid);
 }
 
 static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp,
-					    struct nfsd4_reclaim_complete *rc)
+					    void *_arg)
 {
+	struct nfsd4_reclaim_complete *rc = _arg;
 	if (xdr_stream_decode_bool(argp->xdr, &rc->rca_one_fs) < 0)
 		return nfserr_bad_xdr;
 	return nfs_ok;
@@ -1837,8 +1881,9 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
-		       struct nfsd4_fallocate *fallocate)
+		       void *_arg)
 {
+	struct nfsd4_fallocate *fallocate = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &fallocate->falloc_stateid);
@@ -1894,8 +1939,9 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
+nfsd4_decode_copy(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_copy *copy = _arg;
 	u32 consecutive, i, count, sync;
 	struct nl4_server *ns_dummy;
 	__be32 status;
@@ -1951,8 +1997,9 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 
 static __be32
 nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
-			 struct nfsd4_copy_notify *cn)
+			 void *_arg)
 {
+	struct nfsd4_copy_notify *cn = _arg;
 	__be32 status;
 
 	cn->cpn_src = svcxdr_tmpalloc(argp, sizeof(*cn->cpn_src));
@@ -1970,14 +2017,16 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
-			    struct nfsd4_offload_status *os)
+			    void *_arg)
 {
+	struct nfsd4_offload_status *os = _arg;
 	return nfsd4_decode_stateid4(argp, &os->stateid);
 }
 
 static __be32
-nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
+nfsd4_decode_seek(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_seek *seek = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &seek->seek_stateid);
@@ -1992,8 +2041,9 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 }
 
 static __be32
-nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
+nfsd4_decode_clone(struct nfsd4_compoundargs *argp, void *_arg)
 {
+	struct nfsd4_clone *clone = _arg;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &clone->cl_src_stateid);
@@ -2118,8 +2168,9 @@ nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
  */
 static __be32
 nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_getxattr *getxattr)
+		      void *_arg)
 {
+	struct nfsd4_getxattr *getxattr = _arg;
 	__be32 status;
 	u32 maxcount;
 
@@ -2137,8 +2188,9 @@ nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_setxattr *setxattr)
+		      void *_arg)
 {
+	struct nfsd4_setxattr *setxattr = _arg;
 	u32 flags, maxcount, size;
 	__be32 status;
 
@@ -2176,8 +2228,9 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
-			struct nfsd4_listxattrs *listxattrs)
+			void *_arg)
 {
+	struct nfsd4_listxattrs *listxattrs = _arg;
 	u32 maxcount;
 
 	if (xdr_stream_decode_u64(argp->xdr, &listxattrs->lsxa_cookie) < 0)
@@ -2205,8 +2258,9 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp,
-			 struct nfsd4_removexattr *removexattr)
+			 void *_arg)
 {
+	struct nfsd4_removexattr *removexattr = _arg;
 	return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
 }
 
@@ -2225,92 +2279,92 @@ nfsd4_decode_notsupp(struct nfsd4_compoundargs *argp, void *p)
 typedef __be32(*nfsd4_dec)(struct nfsd4_compoundargs *argp, void *);
 
 static const nfsd4_dec nfsd4_dec_ops[] = {
-	[OP_ACCESS]		= (nfsd4_dec)nfsd4_decode_access,
-	[OP_CLOSE]		= (nfsd4_dec)nfsd4_decode_close,
-	[OP_COMMIT]		= (nfsd4_dec)nfsd4_decode_commit,
-	[OP_CREATE]		= (nfsd4_dec)nfsd4_decode_create,
-	[OP_DELEGPURGE]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_DELEGRETURN]	= (nfsd4_dec)nfsd4_decode_delegreturn,
-	[OP_GETATTR]		= (nfsd4_dec)nfsd4_decode_getattr,
-	[OP_GETFH]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_LINK]		= (nfsd4_dec)nfsd4_decode_link,
-	[OP_LOCK]		= (nfsd4_dec)nfsd4_decode_lock,
-	[OP_LOCKT]		= (nfsd4_dec)nfsd4_decode_lockt,
-	[OP_LOCKU]		= (nfsd4_dec)nfsd4_decode_locku,
-	[OP_LOOKUP]		= (nfsd4_dec)nfsd4_decode_lookup,
-	[OP_LOOKUPP]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_NVERIFY]		= (nfsd4_dec)nfsd4_decode_verify,
-	[OP_OPEN]		= (nfsd4_dec)nfsd4_decode_open,
-	[OP_OPENATTR]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_OPEN_CONFIRM]	= (nfsd4_dec)nfsd4_decode_open_confirm,
-	[OP_OPEN_DOWNGRADE]	= (nfsd4_dec)nfsd4_decode_open_downgrade,
-	[OP_PUTFH]		= (nfsd4_dec)nfsd4_decode_putfh,
-	[OP_PUTPUBFH]		= (nfsd4_dec)nfsd4_decode_putpubfh,
-	[OP_PUTROOTFH]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_READ]		= (nfsd4_dec)nfsd4_decode_read,
-	[OP_READDIR]		= (nfsd4_dec)nfsd4_decode_readdir,
-	[OP_READLINK]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_REMOVE]		= (nfsd4_dec)nfsd4_decode_remove,
-	[OP_RENAME]		= (nfsd4_dec)nfsd4_decode_rename,
-	[OP_RENEW]		= (nfsd4_dec)nfsd4_decode_renew,
-	[OP_RESTOREFH]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_SAVEFH]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_SECINFO]		= (nfsd4_dec)nfsd4_decode_secinfo,
-	[OP_SETATTR]		= (nfsd4_dec)nfsd4_decode_setattr,
-	[OP_SETCLIENTID]	= (nfsd4_dec)nfsd4_decode_setclientid,
-	[OP_SETCLIENTID_CONFIRM] = (nfsd4_dec)nfsd4_decode_setclientid_confirm,
-	[OP_VERIFY]		= (nfsd4_dec)nfsd4_decode_verify,
-	[OP_WRITE]		= (nfsd4_dec)nfsd4_decode_write,
-	[OP_RELEASE_LOCKOWNER]	= (nfsd4_dec)nfsd4_decode_release_lockowner,
+	[OP_ACCESS]		= nfsd4_decode_access,
+	[OP_CLOSE]		= nfsd4_decode_close,
+	[OP_COMMIT]		= nfsd4_decode_commit,
+	[OP_CREATE]		= nfsd4_decode_create,
+	[OP_DELEGPURGE]		= nfsd4_decode_notsupp,
+	[OP_DELEGRETURN]	= nfsd4_decode_delegreturn,
+	[OP_GETATTR]		= nfsd4_decode_getattr,
+	[OP_GETFH]		= nfsd4_decode_noop,
+	[OP_LINK]		= nfsd4_decode_link,
+	[OP_LOCK]		= nfsd4_decode_lock,
+	[OP_LOCKT]		= nfsd4_decode_lockt,
+	[OP_LOCKU]		= nfsd4_decode_locku,
+	[OP_LOOKUP]		= nfsd4_decode_lookup,
+	[OP_LOOKUPP]		= nfsd4_decode_noop,
+	[OP_NVERIFY]		= nfsd4_decode_verify,
+	[OP_OPEN]		= nfsd4_decode_open,
+	[OP_OPENATTR]		= nfsd4_decode_notsupp,
+	[OP_OPEN_CONFIRM]	= nfsd4_decode_open_confirm,
+	[OP_OPEN_DOWNGRADE]	= nfsd4_decode_open_downgrade,
+	[OP_PUTFH]		= nfsd4_decode_putfh,
+	[OP_PUTPUBFH]		= nfsd4_decode_putpubfh,
+	[OP_PUTROOTFH]		= nfsd4_decode_noop,
+	[OP_READ]		= nfsd4_decode_read,
+	[OP_READDIR]		= nfsd4_decode_readdir,
+	[OP_READLINK]		= nfsd4_decode_noop,
+	[OP_REMOVE]		= nfsd4_decode_remove,
+	[OP_RENAME]		= nfsd4_decode_rename,
+	[OP_RENEW]		= nfsd4_decode_renew,
+	[OP_RESTOREFH]		= nfsd4_decode_noop,
+	[OP_SAVEFH]		= nfsd4_decode_noop,
+	[OP_SECINFO]		= nfsd4_decode_secinfo,
+	[OP_SETATTR]		= nfsd4_decode_setattr,
+	[OP_SETCLIENTID]	= nfsd4_decode_setclientid,
+	[OP_SETCLIENTID_CONFIRM] = nfsd4_decode_setclientid_confirm,
+	[OP_VERIFY]		= nfsd4_decode_verify,
+	[OP_WRITE]		= nfsd4_decode_write,
+	[OP_RELEASE_LOCKOWNER]	= nfsd4_decode_release_lockowner,
 
 	/* new operations for NFSv4.1 */
-	[OP_BACKCHANNEL_CTL]	= (nfsd4_dec)nfsd4_decode_backchannel_ctl,
-	[OP_BIND_CONN_TO_SESSION]= (nfsd4_dec)nfsd4_decode_bind_conn_to_session,
-	[OP_EXCHANGE_ID]	= (nfsd4_dec)nfsd4_decode_exchange_id,
-	[OP_CREATE_SESSION]	= (nfsd4_dec)nfsd4_decode_create_session,
-	[OP_DESTROY_SESSION]	= (nfsd4_dec)nfsd4_decode_destroy_session,
-	[OP_FREE_STATEID]	= (nfsd4_dec)nfsd4_decode_free_stateid,
-	[OP_GET_DIR_DELEGATION]	= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_BACKCHANNEL_CTL]	= nfsd4_decode_backchannel_ctl,
+	[OP_BIND_CONN_TO_SESSION] = nfsd4_decode_bind_conn_to_session,
+	[OP_EXCHANGE_ID]	= nfsd4_decode_exchange_id,
+	[OP_CREATE_SESSION]	= nfsd4_decode_create_session,
+	[OP_DESTROY_SESSION]	= nfsd4_decode_destroy_session,
+	[OP_FREE_STATEID]	= nfsd4_decode_free_stateid,
+	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_notsupp,
 #ifdef CONFIG_NFSD_PNFS
-	[OP_GETDEVICEINFO]	= (nfsd4_dec)nfsd4_decode_getdeviceinfo,
-	[OP_GETDEVICELIST]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTCOMMIT]	= (nfsd4_dec)nfsd4_decode_layoutcommit,
-	[OP_LAYOUTGET]		= (nfsd4_dec)nfsd4_decode_layoutget,
-	[OP_LAYOUTRETURN]	= (nfsd4_dec)nfsd4_decode_layoutreturn,
+	[OP_GETDEVICEINFO]	= nfsd4_decode_getdeviceinfo,
+	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
+	[OP_LAYOUTCOMMIT]	= nfsd4_decode_layoutcommit,
+	[OP_LAYOUTGET]		= nfsd4_decode_layoutget,
+	[OP_LAYOUTRETURN]	= nfsd4_decode_layoutreturn,
 #else
-	[OP_GETDEVICEINFO]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_GETDEVICELIST]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTCOMMIT]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTGET]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTRETURN]	= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_GETDEVICEINFO]	= nfsd4_decode_notsupp,
+	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
+	[OP_LAYOUTCOMMIT]	= nfsd4_decode_notsupp,
+	[OP_LAYOUTGET]		= nfsd4_decode_notsupp,
+	[OP_LAYOUTRETURN]	= nfsd4_decode_notsupp,
 #endif
-	[OP_SECINFO_NO_NAME]	= (nfsd4_dec)nfsd4_decode_secinfo_no_name,
-	[OP_SEQUENCE]		= (nfsd4_dec)nfsd4_decode_sequence,
-	[OP_SET_SSV]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_TEST_STATEID]	= (nfsd4_dec)nfsd4_decode_test_stateid,
-	[OP_WANT_DELEGATION]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_DESTROY_CLIENTID]	= (nfsd4_dec)nfsd4_decode_destroy_clientid,
-	[OP_RECLAIM_COMPLETE]	= (nfsd4_dec)nfsd4_decode_reclaim_complete,
+	[OP_SECINFO_NO_NAME]	= nfsd4_decode_secinfo_no_name,
+	[OP_SEQUENCE]		= nfsd4_decode_sequence,
+	[OP_SET_SSV]		= nfsd4_decode_notsupp,
+	[OP_TEST_STATEID]	= nfsd4_decode_test_stateid,
+	[OP_WANT_DELEGATION]	= nfsd4_decode_notsupp,
+	[OP_DESTROY_CLIENTID]	= nfsd4_decode_destroy_clientid,
+	[OP_RECLAIM_COMPLETE]	= nfsd4_decode_reclaim_complete,
 
 	/* new operations for NFSv4.2 */
-	[OP_ALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
-	[OP_COPY]		= (nfsd4_dec)nfsd4_decode_copy,
-	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_copy_notify,
-	[OP_DEALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
-	[OP_IO_ADVISE]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTERROR]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTSTATS]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_OFFLOAD_CANCEL]	= (nfsd4_dec)nfsd4_decode_offload_status,
-	[OP_OFFLOAD_STATUS]	= (nfsd4_dec)nfsd4_decode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_read,
-	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
-	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
+	[OP_ALLOCATE]		= nfsd4_decode_fallocate,
+	[OP_COPY]		= nfsd4_decode_copy,
+	[OP_COPY_NOTIFY]	= nfsd4_decode_copy_notify,
+	[OP_DEALLOCATE]		= nfsd4_decode_fallocate,
+	[OP_IO_ADVISE]		= nfsd4_decode_notsupp,
+	[OP_LAYOUTERROR]	= nfsd4_decode_notsupp,
+	[OP_LAYOUTSTATS]	= nfsd4_decode_notsupp,
+	[OP_OFFLOAD_CANCEL]	= nfsd4_decode_offload_status,
+	[OP_OFFLOAD_STATUS]	= nfsd4_decode_offload_status,
+	[OP_READ_PLUS]		= nfsd4_decode_read,
+	[OP_SEEK]		= nfsd4_decode_seek,
+	[OP_WRITE_SAME]		= nfsd4_decode_notsupp,
+	[OP_CLONE]		= nfsd4_decode_clone,
 	/* RFC 8276 extended atributes operations */
-	[OP_GETXATTR]		= (nfsd4_dec)nfsd4_decode_getxattr,
-	[OP_SETXATTR]		= (nfsd4_dec)nfsd4_decode_setxattr,
-	[OP_LISTXATTRS]		= (nfsd4_dec)nfsd4_decode_listxattrs,
-	[OP_REMOVEXATTR]	= (nfsd4_dec)nfsd4_decode_removexattr,
+	[OP_GETXATTR]		= nfsd4_decode_getxattr,
+	[OP_SETXATTR]		= nfsd4_decode_setxattr,
+	[OP_LISTXATTRS]		= nfsd4_decode_listxattrs,
+	[OP_REMOVEXATTR]	= nfsd4_decode_removexattr,
 };
 
 static inline bool
@@ -3594,8 +3648,9 @@ nfsd4_encode_stateid(struct xdr_stream *xdr, stateid_t *sid)
 }
 
 static __be32
-nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_access *access)
+nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_access *access = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3607,8 +3662,10 @@ nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 	return 0;
 }
 
-static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_bind_conn_to_session *bcts)
+static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp, __be32 nfserr,
+						void *_arg)
 {
+	struct nfsd4_bind_conn_to_session *bcts = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3624,8 +3681,9 @@ static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp,
 }
 
 static __be32
-nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_close *close)
+nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_close *close = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &close->cl_stateid);
@@ -3633,8 +3691,9 @@ nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_c
 
 
 static __be32
-nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_commit *commit)
+nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_commit *commit = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3647,8 +3706,9 @@ nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 }
 
 static __be32
-nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_create *create)
+nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_create *create = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3661,8 +3721,10 @@ nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 }
 
 static __be32
-nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_getattr *getattr)
+nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr,
+		     void *_arg)
 {
+	struct nfsd4_getattr *getattr = _arg;
 	struct svc_fh *fhp = getattr->ga_fhp;
 	struct xdr_stream *xdr = resp->xdr;
 
@@ -3671,8 +3733,9 @@ nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 }
 
 static __be32
-nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr, struct svc_fh **fhpp)
+nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct svc_fh **fhpp = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	struct svc_fh *fhp = *fhpp;
 	unsigned int len;
@@ -3726,8 +3789,9 @@ nfsd4_encode_lock_denied(struct xdr_stream *xdr, struct nfsd4_lock_denied *ld)
 }
 
 static __be32
-nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lock *lock)
+nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_lock *lock = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 
 	if (!nfserr)
@@ -3739,8 +3803,9 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lo
 }
 
 static __be32
-nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lockt *lockt)
+nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_lockt *lockt = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 
 	if (nfserr == nfserr_denied)
@@ -3749,8 +3814,9 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_l
 }
 
 static __be32
-nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_locku *locku)
+nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_locku *locku = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &locku->lu_stateid);
@@ -3758,8 +3824,9 @@ nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_l
 
 
 static __be32
-nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_link *link)
+nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_link *link = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3772,8 +3839,9 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_li
 
 
 static __be32
-nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open *open)
+nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_open *open = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3866,16 +3934,20 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_op
 }
 
 static __be32
-nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_confirm *oc)
+nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr,
+			  void *_arg)
 {
+	struct nfsd4_open_confirm *oc = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &oc->oc_resp_stateid);
 }
 
 static __be32
-nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_downgrade *od)
+nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr,
+			    void *_arg)
 {
+	struct nfsd4_open_downgrade *od = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &od->od_stateid);
@@ -3974,8 +4046,9 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 
 static __be32
 nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
-		  struct nfsd4_read *read)
+		  void *_arg)
 {
+	struct nfsd4_read *read = _arg;
 	bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
 	unsigned long maxcount;
 	struct xdr_stream *xdr = resp->xdr;
@@ -4016,8 +4089,10 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 }
 
 static __be32
-nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_readlink *readlink)
+nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr,
+		      void *_arg)
 {
+	struct nfsd4_readlink *readlink = _arg;
 	__be32 *p, *maxcount_p, zero = xdr_zero;
 	struct xdr_stream *xdr = resp->xdr;
 	int length_offset = xdr->buf->len;
@@ -4061,8 +4136,10 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd
 }
 
 static __be32
-nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_readdir *readdir)
+nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
+		     void *_arg)
 {
+	struct nfsd4_readdir *readdir = _arg;
 	int maxcount;
 	int bytes_left;
 	loff_t offset;
@@ -4152,8 +4229,9 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 }
 
 static __be32
-nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_remove *remove)
+nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_remove *remove = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4165,8 +4243,9 @@ nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 }
 
 static __be32
-nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_rename *rename)
+nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_rename *rename = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4248,8 +4327,9 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 
 static __be32
 nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
-		     struct nfsd4_secinfo *secinfo)
+		     void *_arg)
 {
+	struct nfsd4_secinfo *secinfo = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_do_encode_secinfo(xdr, secinfo->si_exp);
@@ -4257,8 +4337,9 @@ nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
-		     struct nfsd4_secinfo_no_name *secinfo)
+		     void *_arg)
 {
+	struct nfsd4_secinfo_no_name *secinfo = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_do_encode_secinfo(xdr, secinfo->sin_exp);
@@ -4269,8 +4350,10 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
  * regardless of the error status.
  */
 static __be32
-nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setattr *setattr)
+nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr,
+		     void *_arg)
 {
+	struct nfsd4_setattr *setattr = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4293,8 +4376,10 @@ nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 }
 
 static __be32
-nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setclientid *scd)
+nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr,
+			 void *_arg)
 {
+	struct nfsd4_setclientid *scd = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4317,8 +4402,9 @@ nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct n
 }
 
 static __be32
-nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_write *write)
+nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, void *_arg)
 {
+	struct nfsd4_write *write = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4334,8 +4420,9 @@ nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_w
 
 static __be32
 nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
-			 struct nfsd4_exchange_id *exid)
+			 void *_arg)
 {
+	struct nfsd4_exchange_id *exid = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 	char *major_id;
@@ -4412,8 +4499,9 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr,
-			    struct nfsd4_create_session *sess)
+			    void *_arg)
 {
+	struct nfsd4_create_session *sess = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4465,8 +4553,9 @@ nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
-		      struct nfsd4_sequence *seq)
+		      void *_arg)
 {
+	struct nfsd4_sequence *seq = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4488,8 +4577,9 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
-			  struct nfsd4_test_stateid *test_stateid)
+			  void *_arg)
 {
+	struct nfsd4_test_stateid *test_stateid = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_test_stateid_id *stateid, *next;
 	__be32 *p;
@@ -4509,8 +4599,9 @@ nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
-		struct nfsd4_getdeviceinfo *gdev)
+		void *_arg)
 {
+	struct nfsd4_getdeviceinfo *gdev = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	const struct nfsd4_layout_ops *ops;
 	u32 starting_len = xdr->buf->len, needed_len;
@@ -4565,8 +4656,9 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
-		struct nfsd4_layoutget *lgp)
+		void *_arg)
 {
+	struct nfsd4_layoutget *lgp = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	const struct nfsd4_layout_ops *ops;
 	__be32 *p;
@@ -4592,8 +4684,9 @@ nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_layoutcommit(struct nfsd4_compoundres *resp, __be32 nfserr,
-			  struct nfsd4_layoutcommit *lcp)
+			  void *_arg)
 {
+	struct nfsd4_layoutcommit *lcp = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4613,8 +4706,9 @@ nfsd4_encode_layoutcommit(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
-		struct nfsd4_layoutreturn *lrp)
+		void *_arg)
 {
+	struct nfsd4_layoutreturn *lrp = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4699,8 +4793,9 @@ nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct nl4_server *ns)
 
 static __be32
 nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
-		  struct nfsd4_copy *copy)
+		  void *_arg)
 {
+	struct nfsd4_copy *copy = _arg;
 	__be32 *p;
 
 	nfserr = nfsd42_encode_write_res(resp, &copy->cp_res,
@@ -4716,8 +4811,9 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
-			    struct nfsd4_offload_status *os)
+			    void *_arg)
 {
+	struct nfsd4_offload_status *os = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4809,8 +4905,9 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 
 static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
-		       struct nfsd4_read *read)
+		       void *_arg)
 {
+	struct nfsd4_read *read = _arg;
 	unsigned long maxcount, count;
 	struct xdr_stream *xdr = resp->xdr;
 	struct file *file;
@@ -4879,8 +4976,9 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
-			 struct nfsd4_copy_notify *cn)
+			 void *_arg)
 {
+	struct nfsd4_copy_notify *cn = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4914,8 +5012,9 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
-		  struct nfsd4_seek *seek)
+		  void *_arg)
 {
+	struct nfsd4_seek *seek = _arg;
 	__be32 *p;
 
 	p = xdr_reserve_space(resp->xdr, 4 + 8);
@@ -4977,8 +5076,9 @@ nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 buflen)
 
 static __be32
 nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
-		      struct nfsd4_getxattr *getxattr)
+		      void *_arg)
 {
+	struct nfsd4_getxattr *getxattr = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p, err;
 
@@ -5001,8 +5101,9 @@ nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
-		      struct nfsd4_setxattr *setxattr)
+		      void *_arg)
 {
+	struct nfsd4_setxattr *setxattr = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -5042,8 +5143,9 @@ nfsd4_listxattr_validate_cookie(struct nfsd4_listxattrs *listxattrs,
 
 static __be32
 nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
-			struct nfsd4_listxattrs *listxattrs)
+			void *_arg)
 {
+	struct nfsd4_listxattrs *listxattrs = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	u32 cookie_offset, count_offset, eof;
 	u32 left, xdrleft, slen, count;
@@ -5153,8 +5255,9 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr,
-			 struct nfsd4_removexattr *removexattr)
+			 void *_arg)
 {
+	struct nfsd4_removexattr *removexattr = _arg;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -5174,93 +5277,93 @@ typedef __be32(* nfsd4_enc)(struct nfsd4_compoundres *, __be32, void *);
  * done in the decoding phase.
  */
 static const nfsd4_enc nfsd4_enc_ops[] = {
-	[OP_ACCESS]		= (nfsd4_enc)nfsd4_encode_access,
-	[OP_CLOSE]		= (nfsd4_enc)nfsd4_encode_close,
-	[OP_COMMIT]		= (nfsd4_enc)nfsd4_encode_commit,
-	[OP_CREATE]		= (nfsd4_enc)nfsd4_encode_create,
-	[OP_DELEGPURGE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_DELEGRETURN]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_GETATTR]		= (nfsd4_enc)nfsd4_encode_getattr,
-	[OP_GETFH]		= (nfsd4_enc)nfsd4_encode_getfh,
-	[OP_LINK]		= (nfsd4_enc)nfsd4_encode_link,
-	[OP_LOCK]		= (nfsd4_enc)nfsd4_encode_lock,
-	[OP_LOCKT]		= (nfsd4_enc)nfsd4_encode_lockt,
-	[OP_LOCKU]		= (nfsd4_enc)nfsd4_encode_locku,
-	[OP_LOOKUP]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LOOKUPP]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_NVERIFY]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_OPEN]		= (nfsd4_enc)nfsd4_encode_open,
-	[OP_OPENATTR]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_OPEN_CONFIRM]	= (nfsd4_enc)nfsd4_encode_open_confirm,
-	[OP_OPEN_DOWNGRADE]	= (nfsd4_enc)nfsd4_encode_open_downgrade,
-	[OP_PUTFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_PUTPUBFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_PUTROOTFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_READ]		= (nfsd4_enc)nfsd4_encode_read,
-	[OP_READDIR]		= (nfsd4_enc)nfsd4_encode_readdir,
-	[OP_READLINK]		= (nfsd4_enc)nfsd4_encode_readlink,
-	[OP_REMOVE]		= (nfsd4_enc)nfsd4_encode_remove,
-	[OP_RENAME]		= (nfsd4_enc)nfsd4_encode_rename,
-	[OP_RENEW]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_RESTOREFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_SAVEFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_SECINFO]		= (nfsd4_enc)nfsd4_encode_secinfo,
-	[OP_SETATTR]		= (nfsd4_enc)nfsd4_encode_setattr,
-	[OP_SETCLIENTID]	= (nfsd4_enc)nfsd4_encode_setclientid,
-	[OP_SETCLIENTID_CONFIRM] = (nfsd4_enc)nfsd4_encode_noop,
-	[OP_VERIFY]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_WRITE]		= (nfsd4_enc)nfsd4_encode_write,
-	[OP_RELEASE_LOCKOWNER]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_ACCESS]		= nfsd4_encode_access,
+	[OP_CLOSE]		= nfsd4_encode_close,
+	[OP_COMMIT]		= nfsd4_encode_commit,
+	[OP_CREATE]		= nfsd4_encode_create,
+	[OP_DELEGPURGE]		= nfsd4_encode_noop,
+	[OP_DELEGRETURN]	= nfsd4_encode_noop,
+	[OP_GETATTR]		= nfsd4_encode_getattr,
+	[OP_GETFH]		= nfsd4_encode_getfh,
+	[OP_LINK]		= nfsd4_encode_link,
+	[OP_LOCK]		= nfsd4_encode_lock,
+	[OP_LOCKT]		= nfsd4_encode_lockt,
+	[OP_LOCKU]		= nfsd4_encode_locku,
+	[OP_LOOKUP]		= nfsd4_encode_noop,
+	[OP_LOOKUPP]		= nfsd4_encode_noop,
+	[OP_NVERIFY]		= nfsd4_encode_noop,
+	[OP_OPEN]		= nfsd4_encode_open,
+	[OP_OPENATTR]		= nfsd4_encode_noop,
+	[OP_OPEN_CONFIRM]	= nfsd4_encode_open_confirm,
+	[OP_OPEN_DOWNGRADE]	= nfsd4_encode_open_downgrade,
+	[OP_PUTFH]		= nfsd4_encode_noop,
+	[OP_PUTPUBFH]		= nfsd4_encode_noop,
+	[OP_PUTROOTFH]		= nfsd4_encode_noop,
+	[OP_READ]		= nfsd4_encode_read,
+	[OP_READDIR]		= nfsd4_encode_readdir,
+	[OP_READLINK]		= nfsd4_encode_readlink,
+	[OP_REMOVE]		= nfsd4_encode_remove,
+	[OP_RENAME]		= nfsd4_encode_rename,
+	[OP_RENEW]		= nfsd4_encode_noop,
+	[OP_RESTOREFH]		= nfsd4_encode_noop,
+	[OP_SAVEFH]		= nfsd4_encode_noop,
+	[OP_SECINFO]		= nfsd4_encode_secinfo,
+	[OP_SETATTR]		= nfsd4_encode_setattr,
+	[OP_SETCLIENTID]	= nfsd4_encode_setclientid,
+	[OP_SETCLIENTID_CONFIRM] = nfsd4_encode_noop,
+	[OP_VERIFY]		= nfsd4_encode_noop,
+	[OP_WRITE]		= nfsd4_encode_write,
+	[OP_RELEASE_LOCKOWNER]	= nfsd4_encode_noop,
 
 	/* NFSv4.1 operations */
-	[OP_BACKCHANNEL_CTL]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_BIND_CONN_TO_SESSION] = (nfsd4_enc)nfsd4_encode_bind_conn_to_session,
-	[OP_EXCHANGE_ID]	= (nfsd4_enc)nfsd4_encode_exchange_id,
-	[OP_CREATE_SESSION]	= (nfsd4_enc)nfsd4_encode_create_session,
-	[OP_DESTROY_SESSION]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_FREE_STATEID]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_GET_DIR_DELEGATION]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_BACKCHANNEL_CTL]	= nfsd4_encode_noop,
+	[OP_BIND_CONN_TO_SESSION] = nfsd4_encode_bind_conn_to_session,
+	[OP_EXCHANGE_ID]	= nfsd4_encode_exchange_id,
+	[OP_CREATE_SESSION]	= nfsd4_encode_create_session,
+	[OP_DESTROY_SESSION]	= nfsd4_encode_noop,
+	[OP_FREE_STATEID]	= nfsd4_encode_noop,
+	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_noop,
 #ifdef CONFIG_NFSD_PNFS
-	[OP_GETDEVICEINFO]	= (nfsd4_enc)nfsd4_encode_getdeviceinfo,
-	[OP_GETDEVICELIST]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTCOMMIT]	= (nfsd4_enc)nfsd4_encode_layoutcommit,
-	[OP_LAYOUTGET]		= (nfsd4_enc)nfsd4_encode_layoutget,
-	[OP_LAYOUTRETURN]	= (nfsd4_enc)nfsd4_encode_layoutreturn,
+	[OP_GETDEVICEINFO]	= nfsd4_encode_getdeviceinfo,
+	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
+	[OP_LAYOUTCOMMIT]	= nfsd4_encode_layoutcommit,
+	[OP_LAYOUTGET]		= nfsd4_encode_layoutget,
+	[OP_LAYOUTRETURN]	= nfsd4_encode_layoutreturn,
 #else
-	[OP_GETDEVICEINFO]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_GETDEVICELIST]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTCOMMIT]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTGET]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTRETURN]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_GETDEVICEINFO]	= nfsd4_encode_noop,
+	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
+	[OP_LAYOUTCOMMIT]	= nfsd4_encode_noop,
+	[OP_LAYOUTGET]		= nfsd4_encode_noop,
+	[OP_LAYOUTRETURN]	= nfsd4_encode_noop,
 #endif
-	[OP_SECINFO_NO_NAME]	= (nfsd4_enc)nfsd4_encode_secinfo_no_name,
-	[OP_SEQUENCE]		= (nfsd4_enc)nfsd4_encode_sequence,
-	[OP_SET_SSV]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_TEST_STATEID]	= (nfsd4_enc)nfsd4_encode_test_stateid,
-	[OP_WANT_DELEGATION]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_DESTROY_CLIENTID]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_RECLAIM_COMPLETE]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_SECINFO_NO_NAME]	= nfsd4_encode_secinfo_no_name,
+	[OP_SEQUENCE]		= nfsd4_encode_sequence,
+	[OP_SET_SSV]		= nfsd4_encode_noop,
+	[OP_TEST_STATEID]	= nfsd4_encode_test_stateid,
+	[OP_WANT_DELEGATION]	= nfsd4_encode_noop,
+	[OP_DESTROY_CLIENTID]	= nfsd4_encode_noop,
+	[OP_RECLAIM_COMPLETE]	= nfsd4_encode_noop,
 
 	/* NFSv4.2 operations */
-	[OP_ALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_COPY]		= (nfsd4_enc)nfsd4_encode_copy,
-	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_copy_notify,
-	[OP_DEALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_IO_ADVISE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTERROR]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTSTATS]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_OFFLOAD_CANCEL]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_OFFLOAD_STATUS]	= (nfsd4_enc)nfsd4_encode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_read_plus,
-	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
-	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_ALLOCATE]		= nfsd4_encode_noop,
+	[OP_COPY]		= nfsd4_encode_copy,
+	[OP_COPY_NOTIFY]	= nfsd4_encode_copy_notify,
+	[OP_DEALLOCATE]		= nfsd4_encode_noop,
+	[OP_IO_ADVISE]		= nfsd4_encode_noop,
+	[OP_LAYOUTERROR]	= nfsd4_encode_noop,
+	[OP_LAYOUTSTATS]	= nfsd4_encode_noop,
+	[OP_OFFLOAD_CANCEL]	= nfsd4_encode_noop,
+	[OP_OFFLOAD_STATUS]	= nfsd4_encode_offload_status,
+	[OP_READ_PLUS]		= nfsd4_encode_read_plus,
+	[OP_SEEK]		= nfsd4_encode_seek,
+	[OP_WRITE_SAME]		= nfsd4_encode_noop,
+	[OP_CLONE]		= nfsd4_encode_noop,
 
 	/* RFC 8276 extended atributes operations */
-	[OP_GETXATTR]		= (nfsd4_enc)nfsd4_encode_getxattr,
-	[OP_SETXATTR]		= (nfsd4_enc)nfsd4_encode_setxattr,
-	[OP_LISTXATTRS]		= (nfsd4_enc)nfsd4_encode_listxattrs,
-	[OP_REMOVEXATTR]	= (nfsd4_enc)nfsd4_encode_removexattr,
+	[OP_GETXATTR]		= nfsd4_encode_getxattr,
+	[OP_SETXATTR]		= nfsd4_encode_setxattr,
+	[OP_LISTXATTRS]		= nfsd4_encode_listxattrs,
+	[OP_REMOVEXATTR]	= nfsd4_encode_removexattr,
 };
 
 /*
-- 
2.34.1

