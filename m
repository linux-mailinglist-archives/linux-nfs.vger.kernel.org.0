Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9370C5907A6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Aug 2022 23:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiHKVCF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Aug 2022 17:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiHKVCE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Aug 2022 17:02:04 -0400
Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F357C71723
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 14:02:01 -0700 (PDT)
Received: from smtpclient.apple ([151.68.165.133])
        by Aruba Outgoing Smtp  with ESMTPA
        id MFJNo7NcHr8wyMFJToIo60; Thu, 11 Aug 2022 23:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660251720; bh=ga8TZiU3Z6sJv6mHFOKyyAIpHu7yMK7RjJaAaxz3AiU=;
        h=Content-Type:From:Mime-Version:Subject:Date:To;
        b=MfEpoVT1D+JLGp1ZeGlcbP7lXTbY4Ot6snPI2Z7pXdboZ/4/OWQxjyMs37LQmPrbs
         B06v/bC9cUOjcVpSb+4cAirAfE2jCGzB/+3tRAYB8PCWkO5ZUdfnI4gs/6Rl1+AeWL
         SVaa9Xzr+zd+v/U8KuqUJmhxKLUy617t+/QK8DsAUYaHRpLdqqboo7PxTCj+b2pwsg
         MricdFSwot2oZn71VQ9Qt8QM5p/2G8lKn1vmco1w7H5M+4baFRL2Pt3X7KvGHYYRcS
         MgCgvkaqxXkjAvO3b0ThP1+iBzz1yFcNVSK2Rd2OyhciGuqsyMUbCz1XcnYGQJiEXd
         F2ox6Z4PJsFMg==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] nfsrahead: fix linking while static linking
Date:   Thu, 11 Aug 2022 22:36:35 +0200
Message-Id: <881E6E82-812C-4BD8-849C-4DEE484AE4F0@benettiengineering.com>
References: <YvVkftYtIgFhYHKk@pevik>
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <YvVkftYtIgFhYHKk@pevik>
To:     Petr Vorel <pvorel@suse.cz>
X-Mailer: iPhone Mail (19G71)
X-CMAE-Envelope: MS4xfPeJDG4Oguql9iPvvt0hYF7ra64uncmeOwc0Pskqz+Gf8BTgZhQBmEhTu10efiGpzyazv3+Q9JOjEO3m7B0FZYFUf4HNU2Gun8HWUhA0U+pk0ciQ8zKi
 5/JhNBfU3wWbR1ArBfSj7WzvZJPg+g9zDjSsd3OvcVTQaVsxTj74YKXFTxpzb7Dpp8Gb8hZynuPC3APgAXuiGfNXtGUpSXys6XCy31xyCo17sJswPtpvfo0S
 3vFd6Z6SRnAb8a2of9pfrQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Petr,

> Il giorno 11 ago 2022, alle ore 22:20, Petr Vorel <pvorel@suse.cz> ha scri=
tto:
>=20
> =EF=BB=BFHi,
>=20
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>=20
> nit (not worth of reposting): I'm not a native speaker, but IMHO subject s=
hould
> be without while, e.g. "fix order on static linking"

Totally, it sounds awful as it is now.
I ask maintainers if it=E2=80=99s possible to reword like Petr
pointed.

Thank you all.

Best regards
Giulio

>=20
> Kind regards,
> Petr

