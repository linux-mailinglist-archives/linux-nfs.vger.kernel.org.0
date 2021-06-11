Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7463A389B
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jun 2021 02:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhFKAZe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 20:25:34 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:38408
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhFKAZe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 20:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371017; bh=GOgwK6pAmFYKDQPj6wpdrlaF7autK7598uc4qpJw7Co=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SNKm/EBd3rs1jJ41Xz8WOE0jF9S3/SB0zDExLIW4Ymx58ZdzZMpUYqjTm6SeC3hMZQH4G1vnIlubdpjo0RkNtomSLhlAjypA/CsMofxwvZrPQFcHgsPzIlBM3xyGd9q4jKpV8wNoGXodmxxPP8HkbhWOPr0g6uJOHIZsHfOkk2ldNuN9nI2W05IPa6IpWORWINqBFw5BaHXmqvKXFxdheWcF5SH9QeaCOFh8hta9VmImFfvtoaeRUU7ueDx3GS0HEshAqBESvSqwyTghDQjHsaCPDB3jX7cL6rvqXg1C8TzvGMxGOYyQNxBUAOlFHfEJ4PnJwZxy1xSHT/hVEWGe+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371017; bh=O4ku0UD58dh8r4Yf3KZcPbwJ1Wc7Zke0PT0kT8lKcBl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gtX+zWNRY43/cwhqrP5hHD65kwUdndjuOP4M3CY0nlNH483madn6MIsz3o9EebDzlZ4xh3+KhhEIRF08ZXHkeLBGJ1r/E957gLR+M2jv81gN8rmZ+WNy6uHR7mcSbTfHHYjovACPGuc7qOLVUdf+vv98IPJwmQRohvl2OQ9Jw05/+nHK8OfFYysX5P+CIGA4uCQkeIgIOgOLncB4ZrLFHYkVUTdwoEiscPbwBKGqa0tn6Q6ZXEPUKkpJbvXmQEYJRvzcODblmOA/WBsfrRAoUqPQalfCHWQNdGOTHeQ9K+nlfmX3W7JwZsYeKoQCtnonebqpIVYrfa4q3DDV9knV2w==
X-YMail-OSG: UoNpczYVM1mXEy3TnlCiw0FO2C36TvyAsAg.5v4F4aVzErROsAdyyqR9Lzb49Ql
 z5wBPM_zECHedbRiFNNH161hs_HoPYhIHn9iSDH2E5mTusMbJVlwsGBpxZp0WWr7ybkOLN2654W5
 Vt7E3gvuIbnuq8aws9IiIIYzbBESL2jH6NCO3USz3Q0fyUZ6UwkgT9j5sPqIgtmFtjWRX7bFmNX0
 YsZ9ZqVVoTtxNibVFTeqcHlRzJZTY_K0VVWMqCXfRNyxMOypW_YDnUV2Ir8eBUF531VB.OOjdPdo
 Uz1exYP7BOxyUiyZ1nB4q2Khj1.dNOCXfF1_n7HTQrEKWa43isNBLplTx6aGzZKqtIeb8H1maw5n
 8ekCm4wCee_hoS7UDaUSXaS2sb89ZUKJDr4w.GFFEiKz3vawC7jz079Mf251B8nu3hpi9tnCq0m1
 t0cSI1aDDruCdBko2zf89ihV2jYBCDCES8JmLjpDWkZrxEw3yTwbfD4_deUTbv7qzNqgytADK8t3
 A22cALpsXKBOkLk2yqncPLRELht67bOdbLa.x04Yuw.AIU2WellqVI9c9staAaycuH8m2N9HCuTm
 m8YtRsv2ReeGUPffeqhuHjXcihhnOCkBxlmJ4RrHRhqzFmJn7X90y9K_2qZNLS7ITs0c_g0tLTKz
 DZYPXcedjICoKyMK_q7y_gbPyaj8PNqbrTB06jMIcC6kBUWzrLS512fYrhaWDdxrKBrFevO_e3MR
 SYjeuKhBXcuD6bvq8UX3c2RtnPUsu3dCGX.XRObhpHrOJvPq00r9.tzv6Z24LbqW2GJWbBYTkUS4
 xU0Qrx1RoknPRvhjZCfIQDLe2lDMJb4X2.aRpq3daDss2xCqFOYfHdOu4TTHLobcIROYsUA8YE2i
 AZ.40jUVNNuGpGCeOQlIU8xbMlGaRsLPjfg18RU5a7q8iTzdfWHhKZe_RM1nx1aYZa0Ul9IwI6Yt
 PftM5TFV0HinFlZhthHNeS8mK_tcCnJZHrqZX3bNGwy2h7Kcuf6jL0WoEBDDTVF5wpQgmxqA7TJb
 ourr4oP6NcLO5sKuLlAo920bJkcfnj8RMbuNf0W6Dvi5fxLkb3Da7f8i7quhdSPByKltgWz_9KVB
 NsRUAIqvg.OomgxZBiNz6hVCmlOrUZMsL3l3PctDKYm9FIpT3_4pgqbXpGOowU_WDYF0l.XlCMuR
 VX7K2In3xR1ZBysfoJ18uHsr91S3AxsDRBrMYvge3PTJ96PhdSFi.liZAUy5Vk.tOu3CfWWsE6FI
 DB2zc1LuW5DoyqbnG.tfMdHzuOt_tz9YZ4jy.4cZda676PPA39Cx5zAPGSY5Wzfv4XSyE9ZCLy8M
 iuJqezwLttdM6BhtwSHBjJqUakjeeZ4u5KaOjWBxXaj9Gl9XRyltJvI27kMYP7FvY4X6_uqZKXU_
 7wNSjObPuDCsGUV9m6vrUvDWImIZy_AQ6Wfiw5w84FNOOz.492XdZPmAukdNIVwtT9oDdb8CIryG
 aIMBAYaY_6vVGZxrd.lur.0eLpNZ7wk8Baj7Jv1kYLYKzE7BXZtiAobtiKgphEbCk9v8ZbXtJiXy
 dFUAcD7XOjpLggk0E4Dfh8cvTWM6SzD0sLQyx62M58F6XCIkZagklmmxrv03dcbRauw2SMaIdIqo
 bpaI.VU6YA0Xj4xLdI0j1VjhKNHMMzTVC1pdrbmzzB3i9n0hNyo1uqitEw7nACDPj.SkjX5CAhCe
 9xbYIn_On7oR2fIG6aDpqjmgvk3cr6vnp0liC12HGyTMNyjd.0CWXA.R6ddI0qvrM5LO_ekM2wEk
 oMtmYXDo6tv3Hpx92yJF.XclrCbykvuIMAHzAllGHlWjU73YDGd3U1W7QZcs4STrZZqrtWWtbPI1
 Dc1N3XEwL4W0e_bIoNFVk57Jq.bglOqL6vDs2LLxfqKIjz1Qe1PqSJ899g5PC4pDgiiTSPMtiRd3
 m3Uiyf7KauVdCYj390lXHCWjMMiGd18q24wFPeV7Itczcd.9mXbwK.pmsuh_1EuJQWsNig0YhVY9
 ekGDwZXwFr5_r6AvcoCW.uQt8Zpg6V7zi31_BHKaDuWbopSrv83K7bISmfdjGVz1i4hsjIluzMu1
 oYlXtUHjBjJ4Rb5ZGxZCSxBszTfNJidky7j7VVmLj6HIk.cM8Ab_15.gqfnlpRHeKJ_jAo_n6aDv
 EOh1ttX6S8pZosRYHg0yu0l1kza_qYdBMhl_c0xgpdTRrwqtL2kXg1HoGgBCU2ag2CnMKsECzT8e
 LCDWiyHcrQe5AuBoemUedLl40rI1_kFB1XTpSqLOJOVYo9o.HMqrxLA9hjI0NwAj_0YznxVao7mg
 QBCcOfUPZoor9D6c_LTO20WP7wqav_LRgmrgYSF1Fmlx1jzXqGJcGoisZrmUgaD7vRKJ4FgUMexi
 7tr4kqyrLEomNGXwZoGAki5M14D1k80G4amww_vavELuWFYv1yW.y.DN_s6m4KsfEIe5._yyJY9n
 Gft4xb4KF82y_.O9zLAjhj6lb_PYKLRKmLnThdLXSbcsD.tjrBngwCPwZkz.LjKfhxlcSIAcdDHg
 h3BJCJiFUggNkl15YsLaCQlOV.8ZAFFymS0gauTwau4GWsN6dvfuDWEIHg.7deztLO_JzbwfG6_t
 ezhDDXixb9mbyciJIho505floA98qXMt6bUhIjdzzdbN6eZttvhStIH0yBjR_JBuF9MT8xDI8sAd
 nn9dLkJth61t5betnSBzpmyJfAFq.IwstERTHp2Qb3YaBi6rIHeASax3KcV.0Y05OHDGNRn76M3u
 VEod.4iHiR5PEp9Kp9mVVGaOnIOL4oMoErXEkRClCtos1GIlvLrLg_gZJkt313mm6ZVXydw06x5D
 AYwKgpAcpWNzq9ffek6eU3mpzq1dh9R4mw4ECwZzabCJV3xUQ_lWDhZIgmA4ihaO9F9pbE4dWhyM
 2TbhIV2UDZmx.27krGHvYSfi7i8APYaOsi9zdKFxFOM88MepcJjQCTAALdBBFdsZKYv7W1G37Itz
 wmAXPvyA_mtF7WHVIcVLj4krlPOBUPLTkxE0FV29ghO5zxmzRUoWGfw742zN2Vm4edQgq674ccFU
 LlD3MkFDTfjHdWfUH4d_vajXFRbbaR7kaTXkpOvNskMWT7.eOe5OB2h67eNKP.r0VFeidKSXY.an
 bgSYP07QYAOpjjmr__NoG00Gm77KApN.LuBJ.9HXfIYATpc7XbeLVQccJMoFzEBFB7RzxSPzuLww
 Rbmqhz0dKkyZAbzx251q6pY1MQeoM4Q8J1NTT.7X5c3ijzETevexr8ieT5sU.b4D6flY6FbTD0VD
 8S1yddI_X2ZzwqiUsdh1MafjlcEH1tqhZ4AbAkm.CDQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:23:37 +0000
Received: by kubenode504.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID aa413c6f0a8e56062a1b9755d954798d;
          Fri, 11 Jun 2021 00:23:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v27 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Thu, 10 Jun 2021 17:04:27 -0700
Message-Id: <20210611000435.36398-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Change the security_inode_getsecctx() interface to fill
a lsmcontext structure instead of data and length pointers.
This provides the information about which LSM created the
context so that security_release_secctx() can use the
correct hook.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
 include/linux/security.h |  5 +++--
 security/security.c      | 13 +++++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 089ec4b61ef1..fc7ba114c298 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2727,11 +2727,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    struct lsmcontext *context)
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, len + 4 + 4 + 4);
+	p = xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
 	if (!p)
 		return nfserr_resource;
 
@@ -2741,13 +2741,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
 	 */
 	*p++ = cpu_to_be32(0); /* lfs */
 	*p++ = cpu_to_be32(0); /* pi */
-	p = xdr_encode_opaque(p, context, len);
+	p = xdr_encode_opaque(p, context->context, context->len);
 	return 0;
 }
 #else
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    struct lsmcontext *context)
 { return 0; }
 #endif
 
@@ -2844,9 +2844,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	int err;
 	struct nfs4_acl *acl = NULL;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	struct lsmcontext scaff; /* scaffolding */
-	void *context = NULL;
-	int contextlen;
+	struct lsmcontext context = { };
 #endif
 	bool contextsupport = false;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -2904,7 +2902,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -3324,8 +3322,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -3346,10 +3343,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (context) {
-		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
-		security_release_secctx(&scaff);
-	}
+	if (context.context)
+		security_release_secctx(&context);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(acl);
 	if (tempfh) {
diff --git a/include/linux/security.h b/include/linux/security.h
index 666bd85e142b..0129400ff6e9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -585,7 +585,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1461,7 +1461,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static inline int security_inode_getsecctx(struct inode *inode,
+					   struct lsmcontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index de7d5a9bdb76..a5150de2f3db 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2397,9 +2397,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	memset(cp, 0, sizeof(*cp));
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		cp->slot = hp->lsmid->slot;
+		return hp->hook.inode_getsecctx(inode, (void **)&cp->context,
+						&cp->len);
+	}
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.29.2

