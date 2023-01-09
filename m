Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115A9661C66
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 03:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjAIClo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 21:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjAICln (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 21:41:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171B8B48E;
        Sun,  8 Jan 2023 18:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673232096; bh=3Kni2zOeryZbhZV9kxyAGtjQE+96Vd2l5xIQIbH7/Jw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=YptfGmahBtL1NlVjR4zXjAjYQyJ/VD+pKKu3H5oVfD1SP/fFg4hkK5KOFSpYDwdjj
         yHyY+H9YXo15Hm11SAbg2pPLRQ5BQFldPtQEx+vs2Wmm1ApJtZA69Nd2qh/QlQieh2
         8AmDDUhA4hFFjM+RtFgX6WV2J5m8SsW31s8celzEJqfQrbrR6EzhCnD8XygHFX1dB0
         aNQYR9Fgntck6OUdo5UlfCj0Wvkhy9urErO3HAOiSaf9TbGZeqlbUWp4xwhgWZ5Nn/
         RemQrXmGn3QQStCHDTv0A1iV5prGnKzkxTrn4Sr8WEd0Tcw0CC1ltJL2kP3p8HxqVr
         xwbGZHs97eJhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QWG-1pAIG83Cb2-004VyW; Mon, 09
 Jan 2023 03:41:36 +0100
Message-ID: <5a18fd0de4b1d0498905e786b31f9610be76cc13.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 09 Jan 2023 03:41:35 +0100
In-Reply-To: <33eb3085-552b-6a9a-66d4-4b2397b310c8@oracle.com>
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
         <b748cbd9db3a5ac06fe48235ed2a1d110261cafa.camel@gmx.de>
         <33eb3085-552b-6a9a-66d4-4b2397b310c8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ThNhQg7m87Yo044PsUngWTkGGqmtzLvGCktJq/x3I3lvDt4UGaM
 ZYRuuJriArcasqDcFOlXksxIpGGoU5tswp3c+PfXWuD8Ujwz+0ykPICMqI4DQA1ydBqdmlt
 yiVsNXFnUwk44UY6oQh+4haNBA23TkXJ9UN11PeMf79iwLpm5RPdJr/7XYWhn4eO79NkxP4
 9/v7x+3vDCGamOSFddhlA==
UI-OutboundReport: notjunk:1;M01:P0:2kWMZ9E4Ogw=;vZtLhtJKSWD8xYrnlHiG+Z3oIHW
 qVB9B/V5Ch2aVMs7N0c9Qd0atCpC10WQ/xxWeEiQYClaI3xQ92QbZgRW3hdsit72jl1qATMby
 Hnak2d7Wm5pBTKUO16lxNWaKUEkYxv8h930GtNmKGNjQDQNvOe9WuBmSvTsOMl1AKx5YfGzSl
 UOcO33k66nWuaCtrrXVThWtMsqo3iqSuTE3h+rQ03kD/mIgQ1CcwrhTUMzZXf+RQeMNvc2f0G
 1++0YBLPQXAVdpNCIzxzcQMn7oQX8s0AKnALo7PVaSvut6Dr34M6Lilrq6rZ4v8kznvwVxinz
 pL67mlYV7brBXtDEB6C4ltOSPY3IFBMCuQXIRRc+MotUY/aBSqytYsvv20HbjjZF/spgs8sPd
 78ke6I0Aw1y4ZvvD5t08ngH4XathI2FSrv9HQeXAJv2wR2lqf67ZsEXuY+Zap8IbKV8HSbKtJ
 dIoWr3h+XCNB079GRHSMKuIV8gKcN0Nutk3aXeMS8PTeEGRTJGjqnqyb7SnYdsFqmrAvwle+a
 vliueyViauUFZ92YJx4mBjy61A+K7PI3Z3YiKq4RVaGKm86c1mlajCL6imGFudk0mcUsHMuic
 AVi7dW3sxJ8eqSU22RUGNRjEEbi25D33/YG336T2e/IdUufspk4lzX/PsQ+6YnHdjxlZB7FO3
 sjxhx+kPgwWvo4WXYEnnhBaB9Xtr4KKiRPBjmMMkm5hTdu21fv4CrchDXxdb6YH4XeFnvgNg8
 Ni14aJTH5wQ8E1qRHCmAt4jvu3AVmmFvZQfBALvX3a4XJJPwuSm44oe0/78rkgteXouPeJ0RP
 UP2McBp7+THmeRMJlujo9V8E1x0iPssLGv2hLwlvH+i0a0HfzUVjH8/GImPLfNqte2W25ZD1Q
 7akXIRoVHvrW35U//YCbBEA0tLEdwyeu83n4FcwIn0sTffKNwYxnKFbXE5iIi+esChfITqZVJ
 uK22Wypl0z68uSClFDixkLb0wE8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-01-08 at 16:50 -0800, dai.ngo@oracle.com wrote:
> Hi Mike,

Greetings,

> Could you give the v2 patch a try? I will send you the location
> to upload the core, if it happens, in a private email.

V2 cured it.  I also verified that virgin rc3 still does spew/brick.

	-Mike

