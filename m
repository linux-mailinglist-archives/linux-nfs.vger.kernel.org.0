Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE73D6F7A3E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEEBAF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 21:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEBAE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 21:00:04 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFA7EC1
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 18:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683248401; bh=XSlTbUo7LQiWoIvhBeE6OdGziT2EJXp5+t2fogCemmM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QMAdnbtopMx6Ym8NKf2XyWrWEE0oEGVJO8H2TtovB/CNvrguNtMQ8qgm8vcjUW20y/GJrrkh0mFC3L3TXZgCdoDVWfoaOk4X0m5bD/yASF4kCj2QBsu0p9bMzumLBl9OFBel7Nu57AynBy1KpKvliOl2EIM8yLAdy4ybBOUjEjDlNS4B5K4FBLF6SEh4wnmLSFcYaMtAePxluEZRLAb4xk26Pq6GYky4MgFSQmDjy1mPXfX7Kw0Ttzn/rhoelE6MurFnuPZDpwCLFNsrsDDQP/uOF2yIdgc4BptcUeRQJYCMQSVD2oxpJ9Z92eewZs4PV+5BZvdbwQ8SekPuVYa8CQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683248401; bh=lehQzImmGo0WtHzvGVhIjc4pufDPFdv9rEChoYVDWth=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IdRChli01BXh6hlYMMTaEa2IEU4PeJCQaiMKbtqFYgOdaYRkF1+8gtq0m/YDkPiLmjZupLvDxCyFuDWojfPAau54UyigpEd0iyW+75+bIAN9hf3E5BFU5RZShOaKHoe1D/reGtkxWnmCatR3EePYc9NsDr5DDTeUvfC3OkURtw7YSLkeqpaYb5GC3semnoSmojzA93rFK+WkCe0Wj1MlqdZZhn+6TUBB1ZYwpuZUXCJzGFFowra+DqSvArW17WUGXVNHm4UHmjU4sL2lZLX76IX4f2pOPesqBJwbqASVnifIdLEu6NEmbQJLl13GuMr8CaTUdkqfQOiryujLLCJnJQ==
X-YMail-OSG: FuP3TSIVM1lbq94tT4a3N.JpwL4InuHN_MBnGp.Uny_i06PWzZrK13paCpJnEwb
 Hq.uooAcEOqQEMqfOI.OxSCJl3UF6kwa2PInY.do54ltmVy0frGJjM8c8POv9t1pS3NbC7j4_Ry9
 mqkWUfHhCQTcz4LPvkovEi5h5WEM.uyyDv7YNnwP3s9H69iWpyI.cAjVAPXhRw1q6itfwCb7QCid
 NVFlFh7Qr738cP98FE6aEKXuMO9LbelGVC1CK22WGGFYNcBRkfXS.H1mX6EG3rG5fvbcbD_9o9Ds
 J2ExALWRCTNe7GktjeEBehSGCyiivtNUW_.BYIV4BDGjANq2ikDH7W4VGqrfKuLcIfw8e6nT6Yg0
 rt8IfGIYLOTjSuntAaUem0mRDRqeT7Tk5kpM_L9k5Eo1.djW91FTqErpuADCT2jCcFKQkCNcoy2d
 PaQhAAI0vlPA.fMaYhidaKgUj3PAJPhCwFpk.28WOuce_585nhakmY6gGEiuymWP6Te5rN.nrLbx
 6LKnxuPjhrKCa6dOaoLsCAc01BqVT6N2.5ZDqzTOxN.Ab0tpNndZvdIPlxxMyOQfh1zgHd4NJ6yw
 .bDtKd4zGCbtbQQtzTjYdS2hZXWLUteFsPnaK6KLl0cv2ArPrbjLagi.DoWddBz9xO1Rlg8SjGgo
 g.HLsgOCjuBK.0FBeM45.iY77MIrp4wVr24cLI7mVc6BtUKk5j.LZ7yPr7RBfnNNv2oj_.dGwV7_
 5p4vokTNIYRD5dun7hO2sxue2xj0mduWG2ep6WbQ7A84eEmPVshEJ46ovMe5UCqweBROvd5db4jW
 10V0vyiPys4SJ1ZSW4ecifErVYB3YH3iq3oACVLBLrXOFoSKw4z6APu9cbue7yu4MCB.lbZ5Eq1x
 k0g3EqoEydpzXAK5Nfg2d4SfLOgjfLPMcJOmL1CQn7RkrmkGdRJxPPgZGy8bk5VAe6_8MFIuy8OV
 k3I8iZ7WgIsJ40O2WmTN2AWRd03ecwq.jZ1kC34baA6ot.7g1VTbUR8aEiCrnOy73KTy_JNkxmfT
 l0QmpecQXVs1k1GTX2cfuqNLD80RMYK9X8jmeAg2HziWuAZ1XL1hzDOojx2136zYuhWZom4UeP8Q
 lEt5ruKYNnRDF8ZNyb7qVzrpuSUyMaJhm5sgnFAcurK42iWqkf9OGojtrNfxFRbe0yqw2Z_TJsii
 8LJ4MBA7no9GLfmzacfRyXDKaiDzE2EhDmVF_Wzn0esFJ.TEcqNmlVMPwS0EK4p5UZED5lTe8JUi
 Wbmmlz.MC2u4Z86ZAEied1MadCwC9IVVlP7bzoQXUPzD5G7EXQLCo_j_K4CEVUSijiTN8pa2T921
 f3AjTXGrWmbNds65UUNCJR2einU2SCfD_PB3xkA68R7mg6vxc7y1F.80_2dywzSD0Mms8poEw.V0
 CDVjUVHkqPp85caVCVJ3m4E3CKmv0.CPMGkhFoTi6l_cyFXcDuBseQPsL8YsPYHfrQSkc9sMvJ1T
 rOO38PGWUGz.6NQAOtuCYVFedW8SgMqHYwdyWcIcjWBDD_A3x9zAKEbQhjDBaU4S6.sR5fJtiMPB
 EPQoiGtItAk3xgZO972A_QHrrg6kBaEanUp2BdAaAuG4n5HkaQzsfORNYPx9vwU4Z26DAJCXplMX
 lyep0hTx6_qVhplaYKt4zUyTN3Um2cOgB01lm.RXSAYNld2acq87SIsEysSPH5S5Qw6lo5z3Dr13
 A0LEsu67utuvvmUVg2Mf2g3FCg9o8Gr3b4tSLpq20VmZWHAbFP27hW387CDDwHGCJIh8um.QB.Sg
 pldorU8LgnPgXvu2a0Tlfph2wWEJ2T_iS_rSlevz5YwpRM78VvhXeUuT_fehYrjvfngK8yEigcOq
 1.diimhdT.6a2Lw8LJwvON2ZFgNXGOk6fTBZPkOzHoN.k24KgnjYwi9XwnGT8VQ4yuAcFA6WxYsr
 _Iqme_3hBA32R.30m0qKscfBIVTQELWcUoW1DFPwe4izc5xL0S6NHYhLx.KMNkym.68K8ip6JWPn
 kMvlOBsViCMvbR8WcFV2.OFpn2Og4SHtNRwWtynSpaOxJDwzaHbhs7Y20OteGo8WGi6MaaxwsYnM
 pPYdcbNgHP5o6Bqr65Yh2nVOBJJ5tOHOjJgGgkB1QCPAl4imypLPv3W5V77mxsRbSTv1eohalyVK
 3aWfNcWbDYAx4p2v76y529Xkc_Zh4GWJnm0xSCSehkUHpi9ujCslr9QON0YYP3d4dPvfVZnprkJ_
 6kG1EbCgVENw.b_4GddVZxYy9NhwiLDXR67xXpCOgiz36bjp_SLGtyn4Qwss2x4Bu56vDg7oQFU1
 e7A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ad248e1c-0cce-4eb9-b53b-28a788965611
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 5 May 2023 01:00:01 +0000
Received: by hermes--production-bf1-5f9df5c5c4-v79q2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 67027877a1b547b02fe7fa6df3ee4fa5;
          Fri, 05 May 2023 00:59:56 +0000 (UTC)
Message-ID: <d34c30ba-55cc-8662-3587-bb66e234b714@schaufler-ca.com>
Date:   Thu, 4 May 2023 17:59:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: NFS mount fail
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1923bc2f330f576cd246856f976af448c035d02e.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1923bc2f330f576cd246856f976af448c035d02e.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/4/2023 9:11 AM, Roberto Sassu wrote:
> Hi Casey
>
> while developing the fix for overlayfs, I tried first to address the
> issue of a NFS filesystem failing to mount.
>
> The NFS server does not like the packets sent by the client:
>
> 14:52:20.827208 IP (tos 0x0, ttl 64, id 60628, offset 0, flags [DF], proto TCP (6), length 72, options (unknown 134,EOL))
>     localhost.localdomain.omginitialrefs > _gateway.nfs: Flags [S], cksum 0x7618 (incorrect -> 0xa18c), seq 455337903, win 64240, options [mss 1460,sackOK,TS val 2178524519 ecr 0,nop,wscale 7], length 0
> 14:52:20.827376 IP (tos 0xc0, ttl 64, id 5906, offset 0, flags [none], proto ICMP (1), length 112, options (unknown 134,EOL))
>     _gateway > localhost.localdomain: ICMP parameter problem - octet 22, length 80
>
> I looked at the possible causes. SELinux works properly.

SELinux was the reference LSM implementation for labeled networking.

> What it seems to happen is that there is a default netlabel mapping,
> that is used to send the packets out.

Correct. SELinux only uses CIPSO options for MLS. Smack uses CIPSO for
almost all packets.

> We are in this part of the code:
>
> Thread 1 hit Breakpoint 2, netlbl_sock_setattr (sk=sk@entry=0xffff888025178000, family=family@entry=2, secattr=0xffff88802504b200) at net/netlabel/netlabel_kapi.c:980
> 980	{
> (gdb) n
> 771		__rcu_read_lock();
> (gdb) 
> 985		dom_entry = netlbl_domhsh_getentry(secattr->domain, family);
> (gdb) 
> 986		if (dom_entry == NULL) {
> (gdb) 
> 990		switch (family) {
> (gdb) 
> 992			switch (dom_entry->def.type) {
>
> Here is the difference between Smack and SELinux.
>
> Smack:
>
> (gdb) p *dom_entry
> $2 = {domain = 0x0 <fixed_percpu_data>, family = 2, def = {type = 3, {addrsel = 0xffff888006bbef40, cipso = 0xffff888006bbef40, calipso = 0xffff888006bbef40}}, valid = 1, list = {next = 0xffff88800767f6e8, prev = 0xffff88800767f6e8}, rcu = {next = 0x0 <fixed_percpu_data>, 
>     func = 0x0 <fixed_percpu_data>}}
>
> SELinux:
>
> (gdb) p *dom_entry
> $5 = {domain = 0x0 <fixed_percpu_data>, family = 2, def = {type = 5, {addrsel = 0x0 <fixed_percpu_data>, cipso = 0x0 <fixed_percpu_data>, calipso = 0x0 <fixed_percpu_data>}}, valid = 1, list = {next = 0xffff888006012c88, prev = 0xffff888006012c88}, rcu = {
>     next = 0x0 <fixed_percpu_data>, func = 0x0 <fixed_percpu_data>}}
>
>
> type = 3 (for Smack) is NETLBL_NLTYPE_CIPSOV4.
> type = 5 (for SELinux) is NETLBL_NLTYPE_UNLABELED.
>
> This is why SELinux works (no incompatible options are sent).

SELinux "works" because that's the use case that was verified.

>
> The netlabel mapping is added here:
>
> static void smk_cipso_doi(void)
> {
>
> [...]
>
> 	rc = netlbl_cfg_cipsov4_map_add(doip->doi, NULL, NULL, NULL, &nai);
>
>
> Not sure exactly how we can solve this issue. Just checked that
> commenting the call to smk_cipso_doi() in init_smk_fs() allows the NFS
> filesystem to be mounted.

Are both the server and client using Smack? Are they on a network that can
propagate labeled packets? What are you using for a Smack rule configuration?

>
> Thanks
>
> Roberto
>
