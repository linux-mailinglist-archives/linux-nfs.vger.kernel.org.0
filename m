Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0115367643
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 02:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbhDVAcc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Apr 2021 20:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDVAcc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Apr 2021 20:32:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F39BC06174A
        for <linux-nfs@vger.kernel.org>; Wed, 21 Apr 2021 17:31:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so51356094edt.13
        for <linux-nfs@vger.kernel.org>; Wed, 21 Apr 2021 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+HkCmu2qN1/Q9G6ZBrFu+heClj18PH7xJXvmr39biY=;
        b=TAAaIJwzlvt1j1djNhQ/mmmSzScbMlLCRIb7BGsSgvuAvaTzch4FpPRQdnJyBxkzOR
         /3p0ET7GRZWsk6TmGKEPGUotRIAhh+NXFbxe1mcGuZZXO8sqLvXqqD2KYCloSpTpwz46
         U2JhNn4kBIBPNJ2X5L+aK0NPKNLnGt9ZEAX2RojoydM164tzk29uMG+DDRn5azxPkkA1
         DBMARfrFKZZC8m9gtAH6Mwhu4n37BUcMtPG0IHDrFMfWDYAE+5SX4p4gB95tKQ/afj3v
         xppsIw8rW0UE4UrWHTRg96vLuyYByCgDqdzlt92MnkQlfe0v1WzBUDc2SpERiPCprmYW
         hbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+HkCmu2qN1/Q9G6ZBrFu+heClj18PH7xJXvmr39biY=;
        b=q3jRL7giEXT/BN0lkVt0GVILF6va7k/dUHI0uIcKlUHdNmdCNGyZmrmVTHk2YdcSgi
         NMoIjaEoDIyvj0mOR6AIQcvX7M53iCPR8zLlwFVPC0KqFfto/QxzTEMgPgX0zE04dAy2
         gY2EguPOL/IXQQcA6SsxHNfnHEghjiDN5Nm9kPfzhTmia3KFBUnuyLRFSYU/GZFltTp2
         +A763GGCwselEtUlgIeXzZRWxyGsJcv9e3kuTLsDgIX2D31/1v61tcEAv/mCYrySt6Jb
         gNdxiNBkEX5aKFU+YsTpEDxazNRvca9R1RUoOBDvHynECLx2VecyeS5YbIr5GWEbkS9z
         oYCQ==
X-Gm-Message-State: AOAM530AgUdf0z2vI39gotKtJwIWSTpvlUbxlW2OXZ44brCP+V7qxq80
        +8/MqBu23IWkjb23AeYIEQlw/0KtK2fAT37e7/E=
X-Google-Smtp-Source: ABdhPJxQl8Stv9gZsI1aeKjrBSHpEJ9eBRWiyB+cZujAkAeb3LiuM8FcJvS6nGg2FZjKiBegHr7EYirddiGi4bUdNZA=
X-Received: by 2002:a05:6402:2211:: with SMTP id cq17mr689675edb.28.1619051515615;
 Wed, 21 Apr 2021 17:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210409180519.25405-1-dai.ngo@oracle.com> <20210409180519.25405-2-dai.ngo@oracle.com>
In-Reply-To: <20210409180519.25405-2-dai.ngo@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 21 Apr 2021 20:31:43 -0400
Message-ID: <CAN-5tyF_B9LK3soGfbrp8hpS3RG4CdmFxK246u2ADVn+2s0JHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 9, 2021 at 2:07 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> Currently the source's export is mounted and unmounted on every
> inter-server copy operation. This patch is an enhancement to delay
> the unmount of the source export for a certain period of time to
> eliminate the mount and unmount overhead on subsequent copy operations.
>
> After a copy operation completes, a delayed task is scheduled to
> unmount the export after a configurable idle time. Each time the
> export is being used again, its expire time is extended to allow
> the export to remain mounted.
>
> The unmount task and the mount operation of the copy request are
> synced to make sure the export is not unmounted while it's being
> used.

I have done performance testing of this patch on the hardware used to
test initial SSC code and there is improvement on the lower end copy
filesize (4MB-16MB) with this. Unfortunately, I can't quantify how
much difference this patch makes. Why? Because I'm getting very
different results on every set of runs (each set does 10runs to get
the mean and compute standard deviation too).  The most varied time
from run to run is commit time. However, standard deviation for both
types of runs (traditional and ssc) is (most of the time) <1% which
should still make the runs acceptable (i did re-runs for others).
Runs with filesize 128MB+ have more consistent performance but they
also don't show as much improvement with this patch. Note I didn't
concentrate on  >1G performance at all this time around.

Also, what I discovered is what also makes a difference is the
following COMMIT rpc. The saving seems to come from doing an
vfs_fsync() after the copy on the server (just like what is done for
the CLONE i might note) and I'm hoping to propose a patch for it some
time in the next few days.

A few general comments on the patch:
1. Shouldn't the "nsui_refcnt" be a refcount_t structure type?
2. Why is the value of 20HZ to retry was chosen?
3. "work" gets allocated but instead of checking the allocation
failure and dealing with it then, the code has "if (work)" sections.
seems like extra indentation and the need to think why "work" can be
null be removed?

Here are some numbers. Comparing pure 5.12-rc6 code with 5.12-rc6 code
with Dai's delay umount code and for kicks the last set of numbers is
+delay umount +vfs_fsync() on the server. In general over 128MB
provides 50% improvement over traditional copy in all cases. With
delayed umount, we see better numbers (~30% improvement) with copies
4MB-128MB but still some dips and for copies over 128MB over 50%
improvement.

pure 5.12-rc6
    INFO: 14:11:16.819155 - Server-side COPY: 0.472602200508 seconds
(mean), standard deviation: 0.504127857283
    INFO: 14:11:16.819252 - Traditional COPY: 0.247301483154 seconds
(mean), standard deviation: 0.0325181306537
    FAIL: SSC should outperform traditional copy, performance
degradation for a 4MB file: 91%

    INFO: 14:12:54.584129 - Server-side COPY: 0.401613616943 seconds
(mean), standard deviation: 0.100666012531
    INFO: 14:12:54.584223 - Traditional COPY: 0.376980066299 seconds
(mean), standard deviation: 0.0149147531532
    FAIL: SSC should outperform traditional copy, performance
degradation for a 8MB file: 6%

    INFO: 14:14:37.430685 - Server-side COPY: 0.727260971069 seconds
(mean), standard deviation: 0.24591675709
    INFO: 14:14:37.430787 - Traditional COPY: 0.858516097069 seconds
(mean), standard deviation: 0.203399239696
    PASS: SSC should outperform traditional copy, performance
improvement for a 16MB file: 18%

    INFO: 14:16:25.318145 - Server-side COPY: 1.08072230816 seconds
(mean), standard deviation: 0.168767973425
    INFO: 14:16:25.318245 - Traditional COPY: 1.21966302395 seconds
(mean), standard deviation: 0.0862109147556
    PASS: SSC should outperform traditional copy, performance
improvement for a 32MB file: 12%

    INFO: 14:18:20.913090 - Server-side COPY: 1.47459042072 seconds
(mean), standard deviation: 0.118534392658
    INFO: 14:18:20.913186 - Traditional COPY: 1.74257912636 seconds
(mean), standard deviation: 0.041726092735
    PASS: SSC should outperform traditional copy, performance
improvement for a 64MB file: 18%

    INFO: 14:20:40.794478 - Server-side COPY: 2.27927930355 seconds
(mean), standard deviation: 0.0502558652592
    INFO: 14:20:40.794579 - Traditional COPY: 3.3685300827 seconds
(mean), standard deviation: 0.0232078152411
    PASS: SSC should outperform traditional copy, performance
improvement for a 128MB file: 47%

    INFO: 14:23:54.480951 - Server-side COPY: 4.36852009296 seconds
(mean), standard deviation: 0.0421940712129
    INFO: 14:23:54.481059 - Traditional COPY: 6.58469381332 seconds
(mean), standard deviation: 0.0534006595486
    PASS: SSC should outperform traditional copy, performance
improvement for a 256MB file: 50%

    INFO: 14:28:57.776217 - Server-side COPY: 8.61689963341 seconds
(mean), standard deviation: 0.110919967983
    INFO: 14:28:57.776361 - Traditional COPY: 13.0591681957 seconds
(mean), standard deviation: 0.0766741218971
    PASS: SSC should outperform traditional copy, performance
improvement for a 512MB file: 51%

    INFO: 14:36:45.693363 - Server-side COPY: 15.330485177 seconds
(mean), standard deviation: 1.08275054089
    INFO: 14:36:45.693547 - Traditional COPY: 22.6392157316 seconds
(mean), standard deviation: 0.62612602097
    PASS: SSC should outperform traditional copy, performance
improvement for a 1GB file: 47%

    (another run for 1g to get a better deviation)
    INFO: 15:33:08.457225 - Server-side COPY: 14.7443211555 seconds
(mean), standard deviation: 0.19152031268
    INFO: 15:33:08.457401 - Traditional COPY: 23.3897125483 seconds
(mean), standard deviation: 0.634745610516
    PASS: SSC should outperform traditional copy, performance
improvement for a 1GB file: 58%

This run is with delayed umount:
    INFO: 16:57:09.750669 - Server-side COPY: 0.264265751839 seconds
(mean), standard deviation: 0.114140867309
    INFO: 16:57:09.750767 - Traditional COPY: 0.277241683006 seconds
(mean), standard deviation: 0.0429385806753
    PASS: SSC should outperform traditional copy, performance
improvement for a 4MB file: 4%

    INFO: 16:58:48.514208 - Server-side COPY: 0.301608347893 seconds
(mean), standard deviation: 0.027625417442
    INFO: 16:58:48.514305 - Traditional COPY: 0.376611542702 seconds
(mean), standard deviation: 0.0256646541006
    PASS: SSC should outperform traditional copy, performance
improvement for a 8MB file: 24%

    INFO: 17:00:32.726180 - Server-side COPY: 0.804727435112 seconds
(mean), standard deviation: 0.282478573802
    INFO: 17:00:32.726284 - Traditional COPY: 0.750376915932 seconds
(mean), standard deviation: 0.188426980103
    FAIL: SSC should outperform traditional copy, performance
degradation for a 16MB file: 7%

another run for 16MB for better deviation
    INFO: 17:26:05.710048 - Server-side COPY: 0.561978292465 seconds
(mean), standard deviation: 0.176039123641
    INFO: 17:26:05.710155 - Traditional COPY: 0.761225438118 seconds
(mean), standard deviation: 0.229373528254
    PASS: SSC should outperform traditional copy, performance
improvement for a 16MB file: 35%

    INFO: 17:02:21.387772 - Server-side COPY: 0.895572972298 seconds
(mean), standard deviation: 0.18919321178
    INFO: 17:02:21.387866 - Traditional COPY: 1.28307352066 seconds
(mean), standard deviation: 0.0755687243879
    PASS: SSC should outperform traditional copy, performance
improvement for a 32MB file: 43%

    INFO: 17:04:18.530852 - Server-side COPY: 1.44412658215 seconds
(mean), standard deviation: 0.0680101210746
    INFO: 17:04:18.530946 - Traditional COPY: 1.7353479147 seconds
(mean), standard deviation: 0.0147682451688
    PASS: SSC should outperform traditional copy, performance
improvement for a 64MB file: 20%

    INFO: 17:06:40.127898 - Server-side COPY: 2.18924453259 seconds
(mean), standard deviation: 0.0339712202148
    INFO: 17:06:40.127995 - Traditional COPY: 3.39783103466 seconds
(mean), standard deviation: 0.0439455560873
    PASS: SSC should outperform traditional copy, performance
improvement for a 128MB file: 55%

    INFO: 17:09:56.186889 - Server-side COPY: 4.2961766243 seconds
(mean), standard deviation: 0.0486465355758
    INFO: 17:09:56.186988 - Traditional COPY: 6.56641271114 seconds
(mean), standard deviation: 0.0259688949944
    PASS: SSC should outperform traditional copy, performance
improvement for a 256MB file: 52%

    INFO: 17:15:02.522089 - Server-side COPY: 8.4736330986 seconds
(mean), standard deviation: 0.0896888780618
    INFO: 17:15:02.522242 - Traditional COPY: 13.074249053 seconds
(mean), standard deviation: 0.0805015369838
    PASS: SSC should outperform traditional copy, performance
improvement for a 512MB file: 54%

    INFO: 17:22:59.745446 - Server-side COPY: 15.9621772766 seconds
(mean), standard deviation: 2.70296237945
    INFO: 17:22:59.745625 - Traditional COPY: 22.5955899239 seconds
(mean), standard deviation: 0.682459618149
    PASS: SSC should outperform traditional copy, performance
improvement for a 1GB file: 41%

another run for 1GB to get a better deviation:
    INFO: 17:35:02.846602 - Server-side COPY: 14.6351578712 seconds
(mean), standard deviation: 0.19192309658
    INFO: 17:35:02.846781 - Traditional COPY: 22.8912801266 seconds
(mean), standard deviation: 0.682718216033
    PASS: SSC should outperform traditional copy, performance
improvement for a 1GB file: 56%

And this run is for yet unpublished patch of delayed umount +
vfs_fsync after the copy
    INFO: 18:28:34.764202 - Server-side COPY: 0.209130239487 seconds
(mean), standard deviation: 0.0366357417649
    INFO: 18:28:34.764297 - Traditional COPY: 0.275605249405 seconds
(mean), standard deviation: 0.030773788804
    PASS: SSC should outperform traditional copy, performance
improvement for a 4MB file: 31%

    INFO: 18:30:12.278362 - Server-side COPY: 0.263212919235 seconds
(mean), standard deviation: 0.017764772065
    INFO: 18:30:12.278459 - Traditional COPY: 0.373342609406 seconds
(mean), standard deviation: 0.0235488678036
    PASS: SSC should outperform traditional copy, performance
improvement for a 8MB file: 41%

    INFO: 18:31:56.740901 - Server-side COPY: 0.653366684914 seconds
(mean), standard deviation: 0.201038063193
    INFO: 18:31:56.741007 - Traditional COPY: 0.719534230232 seconds
(mean), standard deviation: 0.144084877516
    PASS: SSC should outperform traditional copy, performance
improvement for a 16MB file: 10%

another run for 16Mb
    INFO: 20:18:09.533128 - Server-side COPY: 0.508768010139 seconds
(mean), standard deviation: 0.172117325138
    INFO: 20:18:09.533224 - Traditional COPY: 0.712138915062 seconds
(mean), standard deviation: 0.162059202594
    PASS: SSC should outperform traditional copy, performance
improvement for a 16MB file: 39%

    INFO: 18:33:44.203037 - Server-side COPY: 0.774861812592 seconds
(mean), standard deviation: 0.141729231937
    INFO: 18:33:44.203140 - Traditional COPY: 1.24551167488 seconds
(mean), standard deviation: 0.0520878630978
    PASS: SSC should outperform traditional copy, performance
improvement for a 32MB file: 60%

    INFO: 18:35:44.104048 - Server-side COPY: 1.50374240875 seconds
(mean), standard deviation: 0.132060247445
    INFO: 18:35:44.104168 - Traditional COPY: 1.76330254078 seconds
(mean), standard deviation: 0.0339954657686
    PASS: SSC should outperform traditional copy, performance
improvement for a 64MB file: 17%

another run for 64MB
    INFO: 20:22:39.668006 - Server-side COPY: 1.32221701145 seconds
(mean), standard deviation: 0.0595545335408
    INFO: 20:22:39.668108 - Traditional COPY: 1.73985309601 seconds
(mean), standard deviation: 0.0301114835769
    PASS: SSC should outperform traditional copy, performance
improvement for a 64MB file: 31%

    INFO: 18:38:06.184631 - Server-side COPY: 2.11796813011 seconds
(mean), standard deviation: 0.0407036659715
    INFO: 18:38:06.184726 - Traditional COPY: 3.36791093349 seconds
(mean), standard deviation: 0.029777196608
    PASS: SSC should outperform traditional copy, performance
improvement for a 128MB file: 59%

    INFO: 18:41:20.944541 - Server-side COPY: 4.19641048908 seconds
(mean), standard deviation: 0.041610728753
    INFO: 18:41:20.944641 - Traditional COPY: 6.569201684 seconds
(mean), standard deviation: 0.0398935239857
    PASS: SSC should outperform traditional copy, performance
improvement for a 256MB file: 56%

    INFO: 18:46:23.973364 - Server-side COPY: 8.34293022156 seconds
(mean), standard deviation: 0.108239167667
    INFO: 18:46:23.973562 - Traditional COPY: 13.0458415985 seconds
(mean), standard deviation: 0.0399096580857
    PASS: SSC should outperform traditional copy, performance
improvement for a 512MB file: 56%

    INFO: 18:54:05.741343 - Server-side COPY: 14.4749611855 seconds
(mean), standard deviation: 0.122991853502
    INFO: 18:54:05.741549 - Traditional COPY: 22.6955966711 seconds
(mean), standard deviation: 0.461425661742
    PASS: SSC should outperform traditional copy, performance
improvement for a 1GB file: 56%



>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c      | 171 ++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfsd.h          |   4 ++
>  fs/nfsd/nfssvc.c        |   3 +
>  include/linux/nfs_ssc.h |  20 ++++++
>  4 files changed, 194 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index dd9f38d..66dea2f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -55,6 +55,81 @@
>  MODULE_PARM_DESC(inter_copy_offload_enable,
>                  "Enable inter server to server copy offload. Default: false");
>
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +static int nfsd4_ssc_umount_timeout = 900000;          /* default to 15 mins */
> +module_param(nfsd4_ssc_umount_timeout, int, 0644);
> +MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
> +               "idle msecs before unmount export from source server");
> +
> +static void nfsd4_ssc_expire_umount(struct work_struct *work);
> +static struct nfsd4_ssc_umount nfsd4_ssc_umount;
> +
> +/* nfsd4_ssc_umount.nsu_lock must be held */
> +static void nfsd4_scc_update_umnt_timo(void)
> +{
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +
> +       cancel_delayed_work(&nfsd4_ssc_umount.nsu_umount_work);
> +       if (!list_empty(&nfsd4_ssc_umount.nsu_list)) {
> +               ni = list_first_entry(&nfsd4_ssc_umount.nsu_list,
> +                       struct nfsd4_ssc_umount_item, nsui_list);
> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
> +                       ni->nsui_expire - jiffies);
> +       } else
> +               nfsd4_ssc_umount.nsu_expire = 0;
> +}
> +
> +static void nfsd4_ssc_expire_umount(struct work_struct *work)
> +{
> +       bool do_wakeup = false;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +       struct nfsd4_ssc_umount_item *tmp;
> +
> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
> +               if (time_after(jiffies, ni->nsui_expire)) {
> +                       if (ni->nsui_refcnt > 0)
> +                               continue;
> +
> +                       /* mark being unmount */
> +                       ni->nsui_busy = true;
> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +                       mntput(ni->nsui_vfsmount);
> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +
> +                       /* waiters need to start from begin of list */
> +                       list_del(&ni->nsui_list);
> +                       kfree(ni);
> +
> +                       /* wakeup ssc_connect waiters */
> +                       do_wakeup = true;
> +                       continue;
> +               }
> +               break;
> +       }
> +       nfsd4_scc_update_umnt_timo();
> +       if (do_wakeup)
> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +}
> +
> +static DECLARE_DELAYED_WORK(nfsd4, nfsd4_ssc_expire_umount);
> +
> +void nfsd4_ssc_init_umount_work(void)
> +{
> +       if (nfsd4_ssc_umount.nsu_inited)
> +               return;
> +       INIT_DELAYED_WORK(&nfsd4_ssc_umount.nsu_umount_work,
> +               nfsd4_ssc_expire_umount);
> +       INIT_LIST_HEAD(&nfsd4_ssc_umount.nsu_list);
> +       spin_lock_init(&nfsd4_ssc_umount.nsu_lock);
> +       init_waitqueue_head(&nfsd4_ssc_umount.nsu_waitq);
> +       nfsd4_ssc_umount.nsu_inited = true;
> +}
> +EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
> +#endif
> +
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  #include <linux/security.h>
>
> @@ -1181,6 +1256,9 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>         char *ipaddr, *dev_name, *raw_data;
>         int len, raw_len;
>         __be32 status = nfserr_inval;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +       struct nfsd4_ssc_umount_item *work, *tmp;
> +       DEFINE_WAIT(wait);
>
>         naddr = &nss->u.nl4_addr;
>         tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
> @@ -1229,12 +1307,63 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>                 goto out_free_rawdata;
>         snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>
> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
> +try_again:
> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
> +               if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
> +                       continue;
> +               /* found a match */
> +               if (ni->nsui_busy) {
> +                       /*  wait - and try again */
> +                       prepare_to_wait(&nfsd4_ssc_umount.nsu_waitq, &wait,
> +                               TASK_INTERRUPTIBLE);
> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +                       if (signal_pending(current) ||
> +                                       (schedule_timeout(20*HZ) == 0)) {
> +                               status = nfserr_eagain;
> +                               kfree(work);
> +                               goto out_free_devname;
> +                       }
> +                       finish_wait(&nfsd4_ssc_umount.nsu_waitq, &wait);
> +                       goto try_again;
> +               }
> +               ss_mnt = ni->nsui_vfsmount;
> +               ni->nsui_refcnt++;
> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +               kfree(work);
> +               goto out_done;
> +       }
> +       /* create new entry, set busy, insert list, clear busy after mount */
> +       if (work) {
> +               strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
> +               work->nsui_refcnt++;
> +               work->nsui_busy = true;
> +               list_add_tail(&work->nsui_list, &nfsd4_ssc_umount.nsu_list);
> +       }
> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +
>         /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>         ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>         module_put(type->owner);
> -       if (IS_ERR(ss_mnt))
> +       if (IS_ERR(ss_mnt)) {
> +               if (work) {
> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +                       list_del(&work->nsui_list);
> +                       wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +                       kfree(work);
> +               }
>                 goto out_free_devname;
> -
> +       }
> +       if (work) {
> +               spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +               work->nsui_vfsmount = ss_mnt;
> +               work->nsui_busy = false;
> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +       }
> +out_done:
>         status = 0;
>         *mount = ss_mnt;
>
> @@ -1301,10 +1430,44 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>  nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>                         struct nfsd_file *dst)
>  {
> +       bool found = false;
> +       long timeout;
> +       struct nfsd4_ssc_umount_item *tmp;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +
>         nfs42_ssc_close(src->nf_file);
> -       fput(src->nf_file);
>         nfsd_file_put(dst);
> -       mntput(ss_mnt);
> +       fput(src->nf_file);
> +
> +       timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list,
> +               nsui_list) {
> +               if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
> +                       list_del(&ni->nsui_list);
> +                       /*
> +                        * vfsmount can be shared by multiple exports,
> +                        * decrement refcnt and schedule delayed task
> +                        * if it drops to 0.
> +                        */
> +                       ni->nsui_refcnt--;
> +                       ni->nsui_expire = jiffies + timeout;
> +                       list_add_tail(&ni->nsui_list, &nfsd4_ssc_umount.nsu_list);
> +                       found = true;
> +                       break;
> +               }
> +       }
> +       if (!found) {
> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +               mntput(ss_mnt);
> +               return;
> +       }
> +       if (ni->nsui_refcnt == 0 && !nfsd4_ssc_umount.nsu_expire) {
> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
> +                               timeout);
> +       }
> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>  }
>
>  #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8bdc37a..b3bf8a5 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -483,6 +483,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>  extern int nfsd4_is_junction(struct dentry *dentry);
>  extern int register_cld_notifier(void);
>  extern void unregister_cld_notifier(void);
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +extern void nfsd4_ssc_init_umount_work(void);
> +#endif
> +
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 6de4063..2558db5 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -322,6 +322,9 @@ static int nfsd_startup_generic(int nrservs)
>         ret = nfs4_state_start();
>         if (ret)
>                 goto out_file_cache;
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +       nfsd4_ssc_init_umount_work();
> +#endif
>         return 0;
>
>  out_file_cache:
> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> index f5ba0fb..bb9ed6f 100644
> --- a/include/linux/nfs_ssc.h
> +++ b/include/linux/nfs_ssc.h
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/nfs_fs.h>
> +#include <linux/sunrpc/svc.h>
>
>  extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
>
> @@ -52,6 +53,25 @@ static inline void nfs42_ssc_close(struct file *filep)
>         if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>                 (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>  }
> +
> +struct nfsd4_ssc_umount_item {
> +       struct list_head nsui_list;
> +       bool nsui_busy;
> +       int nsui_refcnt;
> +       unsigned long nsui_expire;
> +       struct vfsmount *nsui_vfsmount;
> +       char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
> +};
> +
> +struct nfsd4_ssc_umount {
> +       struct list_head nsu_list;
> +       struct delayed_work nsu_umount_work;
> +       spinlock_t nsu_lock;
> +       unsigned long nsu_expire;
> +       wait_queue_head_t nsu_waitq;
> +       bool nsu_inited;
> +};
> +
>  #endif
>
>  /*
> --
> 1.8.3.1
>
