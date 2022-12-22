Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC548653AF8
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 04:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLVDmb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Dec 2022 22:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVDma (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Dec 2022 22:42:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0886E18E32;
        Wed, 21 Dec 2022 19:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671680547; bh=r0OzK6/K2zK5Ri/bmQhFWby+lEk9HX7/WMDoa3C7Fkk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NnkJ1A1dbqjBE70OU660pCVgKRucoC0VJ8e6wsSie6PM/ciyw2dttit9B3o/Br7hQ
         Rf1CEoQLBZxCOPzP5r5J2NHxcb4YVzCXfr/toM9GdOrx4PTeyNs8U/aVCZrcLws6fY
         1ME2915dW1OGHuKcFQupl7ouXjQO8+htsg+VDLPi4y2ocJhP4fX9owJMl4rfbF9Nat
         ktqJ7oTjyLgKi6dT6riVI/iuWY+9eQLLrWCRU+St/gS+XxDj9/0VtyxLmZUoF0QRqa
         rdgy0s1xxt3RBBRD0qFY7s90k3+Splfo0AUCbHQTyUxwKJD+aHk7RJf8yyt6tz+DqF
         xlLb0KMxaDrhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1op3IE02Wr-017jnL; Thu, 22
 Dec 2022 04:42:27 +0100
Message-ID: <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 22 Dec 2022 04:42:26 +0100
In-Reply-To: <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
         <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+oWVfH7B5raoTurhi7fj8NVL9M1ztZhwxkW89lsElb2Bgpq8rlH
 0rvvC+CnuhJwJ/Mek69PAe5RoiT7CREfoqm/JnOh8rM55TpAtwKqrIzoQ0vJNn7UA2y3liA
 OCTxpIqCZ6SvIs482abPjBijIggIo/Hf4/EKbjyo1QK+mVtGlKSdDkxPl8+ooEQzjSVC/L0
 RcAZoM9ZjqnRnEXTxMjSQ==
UI-OutboundReport: notjunk:1;M01:P0:AWjDBLvWvi0=;Lk/fuvj0k2yLROYkIgLSmJod9Vf
 iBO3sHjRlO0ZNzS8xiewX0L7Sj9BmuhpbUgfMnpKhhuwgkbKXFv+LI/Q73vBnXRuWK5bAjxr/
 7jj9V4aEluoAweSaCgnwiZC3wuE/O7Jbq4cqGC20sKfCBGIjVD9D0HXH9xeqJPT/UiGG2+KmJ
 3u3IEPmGWuuhpGOZkVMxob+5Bg7paWHGC2JeMaaL8Fdu71AWhzwT5S1/zEPZmGHXrsMA/tuxo
 gnP4idWmhEuWcS9bO3voiPQNJUooSWz2fbHyndZ8iApYDSpsHiF/z3c0V8KZF5bE14ND/iWWi
 Z74IzmhAm/bZX52Z5K6W1qL//9mCjwO1/NxUbf3KrBEunTvBlAPFaJpim+e/fuECSA7A8tNyx
 NTBOIsTIM5V+yqe0LUm9syZAcS5NPlURQQngUevqBfi4AAM0WOZdUMRFoU3FIuwn5XoxtVUUo
 uccr0ZJi2MqzmmEB06plEJ5UD9eLRxr9pkZAE6sC6HOF2nX5NYDbxRpmxXSdBJw/yKNT0SNC3
 Y5f0fzbQ4FpaLOzlwXu3t9gG15yhl3rr6Y4rFcxHYpchF+xAflificNncrV2RUrc/xy33ftbf
 eRPqvB3zXdnbT1GqEm0Y+9rbRDBXScgjj9t6BlxKunu4FuxY/OIWpiJ3AOCwx1Zserfu7yY5u
 HwJU7d0yPaY0gEdV/UJnnI83UIPjWgZNoz+1j0jj6o/da7g4CPvht9mcJ9M9/tFVvxP3Tgkzy
 1aqajnLOo+pKvnV4a2MZpcCYGhjepdLiQLvAjNje+lkarF+5CNzcmsUbINdGmNMp6ewBiGJt5
 2kiCL0hdHkNwXIJ7+dcZXUeT+DTMH8yhx5zzDfJz0bohrNx/HLRwzmYp1dNHeQwal8GC3j7dp
 Si+VHJX5xgnFQZevJ/ajtdNtWgyrlCD4qYxxKx5km1pd4+S4kchbaLg2lRae0F5q5rCCZ3xlH
 B42O1jN9ytOwAihdGqrfD4+fgBg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-12-21 at 10:56 +0100, Mike Galbraith wrote:
> > 6.1 didn't reproduce either, so it would appear to be a merge window b=
ug.

Ah, not true, turning evolution loose in nfs mounted home and letting
it refresh mailboxes while desktop box was kept busy jammed up 6.1.0 in
fairly short order. =C2=A0

homer:..debug/tracing # grep WARNING: /netconsole.log2
[ 3309.873094] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1655 __queue_=
delayed_work+0x6a/0x90
[ 3309.873446] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1657 __queue_=
delayed_work+0x5a/0x90
[ 3309.873780] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 3309.874120] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 3309.874452] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 3309.874783] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 3309.875099] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 3309.875426] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 3309.875745] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 3309.876064] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0
[ 3309.876383] WARNING: CPU: 1 PID: 78 at kernel/workqueue.c:1500 __queue_=
work+0x33b/0x3d0

Sigh.  Ok 6.0, batter up...

	-Mike
