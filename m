Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2B42A8776
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 20:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgKETjb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 14:39:31 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:41011
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKETja (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 14:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604605168; bh=yeGzDTn11pZYHAlhwK5D5PkK5UrVNOIRPiMTnbvxlSg=; h=To:Cc:References:From:Subject:Date:In-Reply-To:From:Subject; b=L9EAF/yOVgeB7a1uiVCGPuimzcCjHeSoV1oUYUkEy8Rw5BWxKt6W/QYwnDSbVLNzef8PQVDuSV5shTDQh30ZGQ9GCaJ7hcPVtrI0VzBsDfpEQHDVvRDW/13KmVZdA0kVk2sI9yqjArH/L4yZPwCO8dVXzEooRrGl1pgTm9FMzZwHURXMcYde0usi7LMlQ8OBWWsfRoxuP1vOFaPGIcQboYUF7jtI+3GXxXp5pB+ND0S0jPHToln5cbzGa72SDVgVbAXxNOUmnrYiKSej7M5K+u+T/MKenC2ddFDygTby25z/ZvO9KwK5ZzTRaivtKFIxrdtb7Rr2GtsyDrgt1NH7uQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604605169; bh=ESTqZueWvPPgDt0rNWAwXrDF1Eu9OodtRNvnlgwvPLm=; h=To:From:Subject:Date; b=eWZP4d9SRQJg7hvQktIBMUU0LfJiBkbJl3ReR/heNu6i8b172rm/Jv613Qdj5QzMZJArgFv65YfKZ4gYtBX6QD9LS5Cx00blvvZhWClhvkO0t6zCdJwmD7G9IIUqOeiRuilxg+2e34Lgb/xXoWAWT+ydnrRWGxXyLL3BXgCnLpTdCtR2p4TgPQ+An+HCdYSCR1dKTKCcVmfbxesWJN4ikZo6zpvDfonuyaB+l11Ij+TMw2Bp0yOGyFtoJpuI8YP00OenwY5MYirflwIVgD0z5ConQS7V8taeYYUP7ZE9Lr2bo1sPPMYb2RuUykEC4EezfOn+twY1tpD0J8NlUzHVSg==
X-YMail-OSG: 0t5oDt0VM1lWSibYg90uqq1JCYXCCJzuTHMNaTJ79E7sGKoqhkEdGvNAyMkCzET
 G3oS6.PNSFcV5f6o91RhGBsdq68ABoCdhqaMp.MB56MoomM9u8qrLnf19ENXAH4Oh3c6BH7oYNEs
 7v4M8RReLPtKMFUuRtSixgbAoCPa303OQTSQrqgrGBgetzk2cYLdjPWok8iO8wiseIRchFQWrDyC
 xIRyyaCPSH8ZcnQGLgp4OmpY1gQDT8oZOVwFFy9.DivWufpfmpvXpS.g5X4UHfsZKWYjwD8KcXNj
 Y.8.8Nz_GuuGfrrmKWzyp284enVI5AKnjrLm1QPvgaXt3MHArUvIs88EswZ1gQi9Le4IJR17CP8s
 MZqIc9c1lzH11Q5YWY4rP21Tf9TYM8uX_._CpdIt3pcuwYhLgaAXeZTNeRmrVlr5VEYdZ5xZYeTf
 2ICcZ4AkUy9G2N4EhI11ZqQKHr_ngM3qxieM.gTJgeoOgUdN0YhprUixRFrYVzjnWzOajMj9UcCm
 a2DunCwnK2ATRcD4XcEaYSRK4Opu.B.v0YRZn4GfQbu8PimVdNn3WMQgJ2dzA18JJqvOHV42Z1Z4
 S0nUPfHS8uwUtPNt8M0lZsCwbPOGs4dHZFlhfXvot7bzjNEYDFwgy2RKJcZKB6bPf7T5PV6gGW5H
 4dYEd_nXQns43xL5gRiGs9ctEh24eYPZ4jL26t1HSFDvrV6JNZ9jZXqj5eSfTfZFpjJA4nEnun.C
 05Wi.w5rrWfdvYlF8fPuBiJr6.rmpO7Q5BbdDKyBkcwEjaQrZs.TJy5N0WiSxu2RqL4lPn14yng2
 AOndlBKjeylRfRcSGUmym8Dq8IFvi4pzOnQIstSa5iEItlfbBMkhc1IkQl0._Tf4tb4ppTLNpxjz
 8ASVojswc8GwzIlv2Dmi1riTLPmbkt1WkuJcdsbcjShbaQmCqMoxPViIud80DKpFBMEYVKCqxQEd
 8HTq5qWpXgr.tqTpkoC7CXOfOF0Dbo0aBGt_GanFzFt6YwQ4Fu6ZNA7FGAk5.rGWmO7GQKH3768Q
 FP_AEELx5OkqYf8cEONk65.RClIhL_cbt5x0E08cARQ79JYG5pmQIEngQ8Wae_ze4quCplHji2US
 NbU3boIcxofzIWa4KfCoA0iRd_vf1OW6wbYwJV8zjb1QF1CBj225SBDRDkGkGpaogH5uc93ew7WP
 FFf.naDdm21xDWlVWvRq0LPQOAb5K1rY1yIp37GTzEc29nfLqgNP2vzwipWFUoRIOzVehOc7RDgm
 IIBzCMWydCZ_oWiIKyMFfo_QAPaOQ5tZOodwZ.jOSLL8_V1Quw7AZYbzvLjvPzgcM9ktd6ABPzny
 Qrvg9xMj2z5V8DKDR5mFQAid.QbFl..rbNb7TiCap5a5geB8eokAeeiFICjWbLNxYUixHfRy0nFR
 .JRm2QzuHmdVspbBEX3v_WmLAZE1nqblAxSzavui5iJSCUp85RnLCDsaiBzgZGNN86es.F9c3RDn
 Xl3RwxJWacKBliNilOm_viqkdBIK7a_2Xgnw7krJt5jBqAese0gc1Y0MQr__DHGXKINxjHx7sAd0
 q6rwQ6xcovknJTIPMRY17BeMbP7XmeTPaM.cFQux9eyCtj02gVSKMFShkGpOV9xNxiXG_gjmaPb9
 .YMmsC6sx0ccGpXtnhJlvgswVRrUCye88qDDQOpWs_4D0gysWqDWkQ7DpFT7f6ENAkiBiip950Qa
 2JSvaH6DwFleUyawZ4PczqS0xi4Oc0sTUmRUlc8G8F0Vlz0xQKd5Z4fLIkwb3mDGefouaSes2hQt
 HoFpxnAgvLNZYAGOKFgLE7B4CgqSZf_b8BgiYbP2bsB3SvZ2JVFOS_cjWikoIyvXU7mNzxiO243C
 sj9.0hwf7GX6zN0wQHMVHkPSYDgEatUxkhB2zofctT_LdxIK_wuWDa34mYKi21rLrlvg02yYagb2
 MjQbNODuzSGfhkUGGzC4GNiXyR1g55P5oIl5NGcmqb072gbG.Q7Ym5No9BQGk6lUPnkszxWMbfc7
 m0LGQrGaAMhhPW0mEwMvTGS46zguJadt9eQWIRWhlhHTFWKZvSerzSPAr6MqsmFlPW4_jVCaUdGT
 V45t_oOsJWr22VOF_LLxMpDBW2H0xQAjHwuF6Yj1sEOGiVPutRAo_e7qh_vDV7aLzRsHO7Kk1fy9
 ZtRGxHzL3xbZtR8qEWj7t3XmKu6gb_J7t4KVJrPglqZvEyAM3JFZugHD.AwKQfbKSDmplz.K7_V8
 R72Nalq0Bzuaz0x1WwL6CcwB1gDGbRp4B7VVgUPIE3wvIfuKwlBPjFrM5fHf1YW2DMW1VHarEquo
 nLT8JbPlNAwQnzsNZ3.j58Qad9bEREl6fz0RFgH0Q3xSWKHv1sbANcXU81pZYfbftvwPE_ZUxRIl
 78qhXQp.oImumwv3aMCH7mt613Dmf2fbkh9pEDGtowt.4l_nuI5n5ibVen0cUvGQMnbu3HGddZdZ
 PU_OfiCQIqFWcxPx_ehgk3p3GlDSunBjfj5WQFarAeWOgH8iviZfb3fo93KyO1CegEzJ0K4a_Xwp
 PGurMDL7ZHwXgn9.PhMD5gXF6XRnbkbdNjlZd7PHWnuORezz4ap6dOrNrjvUYng7u17oD_U4PTYT
 xKP5KGTB31rbd7a7xEcdYD1XJtXIHv9Xrxixv6u2Dmj71nL0H7ayzeUiPxR.6dsNHwNPRRB1BS1m
 Ce9c7.vK4U3VA5SSTDvMC7vcG8LMUW1_FQxztPzSCm8AR6PtE3fEnZCHe83idfcyNDTaeF5_74v5
 zWzc0QKWJQdZyGuYp07_7bxZlZmGnjFAlfhc_Xp076cz3XXY7ZiB5o99h2kC1FCfQcHQC.J8kNja
 qQO5hOBQSJsfgfF9CfCiR7ySPtq7hr3H2HSdrFupXtKEpbjcg9jlW1ATSXZnqMj.Cv48GMZJHewW
 .QBRwcbvAA5YWjL6xmILNPClVVjtE6l4hIqIB4kzGGGIFZiscHEr1E9TeOH6lRFHnBbLB5Y5tyhV
 NfQfDsoUgWUexG8JuIgq2GJUx.9lQlrHcUD0Xv18xCYw08zicPCdkScVU9CfNg3AcChtL4W1YmCD
 5s0gX8Pok7g0lFoDIDUB6JJ8J0KW09ZDY2u72u4duaNvS53thN2ChI7NeKI8ZNaZu7OlQNgm8ZtV
 nEvaHHt_9.YDWCBManovMMx9.SUTVwH70iiCx_as3UqKy.qCjbIst8o.K8Sb4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 19:39:28 +0000
Received: by smtp410.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 089eb3219800930c805981760dee0e96;
          Thu, 05 Nov 2020 19:39:23 +0000 (UTC)
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 1/2] [lsm] introduce a new hook to query LSM for
 functionality
Message-ID: <30b2b09e-c274-e349-f50b-570e24b33f44@schaufler-ca.com>
Date:   Thu, 5 Nov 2020 11:39:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11/5/2020 9:33 AM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a new hook func_query_vfs to query an LSM module (such as
> SELinux) with the intention of finding whether or not it is enabled
> or perhaps supports some functionality.
>
> NFS stores security labels for file system objects and SElinux
> or any other LSM module can query those objects. But it's
> wasteful to do so when no security enforcement is taking place.
> Using a new API call of security_func_query_vfs() and asking if

As I mentioned earlier, this is a sub-optimal implementation.
Instead of adding a func_query_vfs() hook add a field to
security_hook_list and have the LSM declare the "features"
it supports there. security_add_hooks() can gather the "features"
for the whole system into a single mask. security_func_query_vfs()
can then just return that mask.

> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  include/linux/lsm_hook_defs.h | 1 +
>  include/linux/security.h      | 4 ++++
>  security/security.c           | 6 ++++++
>  security/selinux/hooks.c      | 7 +++++++
>  4 files changed, 18 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> index 32a940117e7a..df3454a1fcac 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -257,6 +257,7 @@ LSM_HOOK(int, 0, inode_notifysecctx, struct inode *=
inode, void *ctx, u32 ctxlen)
>  LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u3=
2 ctxlen)
>  LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
>  	 u32 *ctxlen)
> +LSM_HOOK(int, 0, func_query_vfs, unsigned int)
> =20
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
>  LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index bc2725491560..e15964059fa4 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -456,6 +456,10 @@ int security_inode_notifysecctx(struct inode *inod=
e, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctx=
len);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctx=
len);
>  int security_locked_down(enum lockdown_reason what);
> +#define LSM_FQUERY_VFS_NONE     0x00000000
> +#define LSM_FQUERY_VFS_XATTRS   0x00000001

This is the wrong granularity for the task at hand.
You don't care if an LSM supports vfs xattrs. You care if
the LSM provides an xattr that may be propagated by NFS
for the purpose of mandatory access control. An LSM that
provides time-of-day controls may use xattrs that are
meaningless to NFS.


> +int security_func_query_vfs(unsigned int flags);
> +
>  #else /* CONFIG_SECURITY */
> =20
>  static inline int call_blocking_lsm_notifier(enum lsm_event event, voi=
d *data)
> diff --git a/security/security.c b/security/security.c
> index a28045dc9e7f..502b33865238 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2067,6 +2067,12 @@ int security_inode_getsecctx(struct inode *inode=
, void **ctx, u32 *ctxlen)
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
> =20
> +int security_func_query_vfs(unsigned int flags)
> +{
> +	return call_int_hook(func_query_vfs, 0, flags);
> +}
> +EXPORT_SYMBOL(security_func_query_vfs);
> +
>  #ifdef CONFIG_WATCH_QUEUE
>  int security_post_notification(const struct cred *w_cred,
>  			       const struct cred *cred,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6b1826fc3658..38f47570e214 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -92,6 +92,7 @@
>  #include <uapi/linux/mount.h>
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
> +#include <linux/security.h>
> =20
>  #include "avc.h"
>  #include "objsec.h"
> @@ -6502,6 +6503,11 @@ static void selinux_inode_invalidate_secctx(stru=
ct inode *inode)
>  	spin_unlock(&isec->lock);
>  }
> =20
> +static int selinux_func_query_vfs(unsigned int flags)
> +{
> +	return !!(flags & LSM_FQUERY_VFS_XATTRS);
> +}
> +
>  /*
>   *	called with inode->i_mutex locked
>   */
> @@ -7085,6 +7091,7 @@ static struct security_hook_list selinux_hooks[] =
__lsm_ro_after_init =3D {
>  	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secct=
x),
>  	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
>  	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
> +	LSM_HOOK_INIT(func_query_vfs, selinux_func_query_vfs),
> =20
>  	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect=
),
>  	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),

