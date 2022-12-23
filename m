Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86EE6550B6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Dec 2022 14:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiLWNFp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Dec 2022 08:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiLWNFl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Dec 2022 08:05:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2BE28E39;
        Fri, 23 Dec 2022 05:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671800730; bh=GBRfOiJIoTJ0SgdGqOmfTqjGKOV/lkzAjWX3IU4QfnE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=WpXVANo7jaYQA8zlLgSQ4ShHma++21zlnEM5XeUMMwypqjFzC0gKpyKLlwYajcMSr
         syFoyIrBzJViGlbR8YrxOOJIK8yC+Or/zQ9kryKq2V2/lfPKx93dQQkhS0zNSTHXy5
         4hhtv0yfQBsd6kOc8WZ/yrI37qB/zMLga6wfsw6fmsXpq5/zfbWv9/txZp/fjTBYaI
         YWwyQ/hdAXvMLpYh/v09gXd4Cfc1OBA8IpqayfK7MRlegavF/WmYBshnc37jLoN5mi
         33uZsBn4108aL+3K0DDuT0wcHeSxuhRglBNPnFFYYkG+KAfE5A0EdK4kihbzJ1wriF
         OKXl9x37V7K3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from bart.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1oxvwf20Wh-00yN0q; Fri, 23
 Dec 2022 14:05:30 +0100
Message-ID: <b748cbd9db3a5ac06fe48235ed2a1d110261cafa.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 23 Dec 2022 14:05:29 +0100
In-Reply-To: <ae11915e-9253-4049-e9a6-31432679d27c@oracle.com>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
         <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
         <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
         <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
         <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
         <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
         <e51b8b218f18abe00ec76eb911d5b5b5af02f79b.camel@gmx.de>
         <AF3DFAF9-CF19-40AE-8B8F-31D100E00F33@oracle.com>
         <a0abf7fef412dc0de0e42cbcd75ee5dec28cb544.camel@gmx.de>
         <cb5508d260288126212453486d6d45e84436b530.camel@gmx.de>
         <ae11915e-9253-4049-e9a6-31432679d27c@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hjvH12N9QqdvaOrRSyPkEZpQvLYBGEDFOsUd3USbdGm7DL+IHmp
 QBQcfzUCetTCfGXJhiEPPXYfCD2JPwTCqv2SK/aL++0eIRd+QwZBTAkgppF/wvNDg5A+h9U
 5xBvNeDgx6kWLtzkfVDJq9SGzvh6CH1LmztnVTuRCOt26gMXKElP+GbEeYIgL668YoH4zOh
 IoogH3iFiJ7mpOctIVVQA==
UI-OutboundReport: notjunk:1;M01:P0:L09f0NpYEtE=;8sD/qcBfqtyi+hOpeeMVmYzc8X2
 brBfjN0HaYAS3N9J5dk3BpVY6kHpdEvMGrEQ51QVISK/9cMvPiShIpEPSqLKNQQTOYcSk5CrS
 tbRUI9L8Ej/8PJ+wq1DVfbKCkcju103rlpPrAetn3wiNE0hLO8A75V0xkkDra4Kh/GghCZvH1
 6Fk37xL+iowhql5cxQG1Xm18e7hM6SkCsjLmiTIS2oLZpjG9ncAZ+SobomQ+KFlOYkGn+o3Zf
 Owce81W1IhNv21g/HGVffSPKqR+nzkoo+8s7KRSU9GtkxT08nAYd7L/rVNBJdSVod5alu67d9
 YUCp3W4sJtpBx0DWqBDjnsmsaacpCCdwkumr8JGKeOjnY8t/EXdjzPAAm+nK+R2uVcUNKLKSO
 eCws9KIjkbkilK9Po1MoaWGmK4ll55lGfwZhRiArsoI0e8AbUcatTBDzeWNt9UMxYczWvbAHR
 Hzsax6up56n8wUOPIzMclmBR2tI+Aabg51CMurLHfiUb5ChbCA/XJoafp25xyBfPaYI12p9ap
 uH0jc76tOaqtb+6MoxjEl15Mo/tDlfE0t58UiRfE9J0RlddhE8JBYkgsx/kILKfbGoyUkfd3s
 Pd0PNVBcOYKiQ3Vj3tv4YF4ainfAaxc/e5EXOHbJZZsKKr6VmAKGlPDtwVs5nknQTa1wsXc3e
 pI+HfmvLNaayl1Fs67BI/ksRD7MXLgLcjMyCYEOgEmza0eRm5QhNwzz+hKWSc+pVmBx84i7Dr
 nIZCi2ortWcTk0jXtSk6ByzIPeLK+7mQKToKiBcm0eXqr7beLTXWW0+IwKU1FNy3Ce7n0Hpva
 z258rmw9RlKr6mK3cKbNzVn8iHCbvJfgG+wAHdt7Q3BytAbqZqxVxnvyceqjjqSCCh8UnShj+
 UWQvkP+YNoRAIQY1hPhqXXtvlskyU8kH+Uk8ONUXYhb+o7Zn7fAIL7mSf1qRgKt0dJBY8gQaM
 7Pa1RKNOyYrDbDvJvKpRZmhAyck=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-12-23 at 04:02 -0800, dai.ngo@oracle.com wrote:
> Hi Mike,
>
> I think the problem is the nfsd4_state_shrinker_worker is being
> scheduled to run multiple times. This trigger the WARN_ON_ONCE
> in __queue_delayed_work.
>
> Could you try the attached patch to see if it fixes this problem.
> I tried to reproduce it on my test VMs but no success so I can't
> verify the patch.
> >

That was a nogo.

bart:/root # grep WARNING: netconsole.log
[ 1030.364594] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1655 __queue_=
delayed_work+0x6a/0x90
[ 1030.364970] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1657 __queue_=
delayed_work+0x5a/0x90
[ 1030.365315] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 1030.365666] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 1030.365992] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 1030.366333] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 1030.366669] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 1030.366995] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 1030.367317] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 1030.367636] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 1030.367962] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0

