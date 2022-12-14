Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1564C215
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Dec 2022 03:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLNCCw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 21:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiLNCCs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 21:02:48 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457E915835
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 18:02:48 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f3so1085250pgc.2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 18:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEUg1choN2VLPQjRx4iLadaOIPPlWAq7XP9eTBQe//I=;
        b=AsrmmDy9qv6zvseEWARPMHibJH/73SEVcoL8RTm6+SHIV0O5kFHxwzvMp8APyY1ag+
         mjz7sI7HmrigLIlvM7jaDjpXhMXyWN5/LAAUJfer/h1IvgNZEsdYcXS5iVCwGT+EVYRO
         VpTKuTCHSUSNDFHROTguTr015jlPUaK8ryVM2EBIcnuJNtQKYitZfidSFvw/NI2huVl0
         yYT+0xc55xJp/YE7cwiJ0OgLOFSrAlI4pv9wWp3yRCmtHGsdNVO/Hb4Gav40ypaGW/us
         LLtO9dJccZtxoDQqW2HdXyC7rnDPBRJAY6aKHuwKtSvRbjOF5m40gloQTQ1kNQSr12i8
         OCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEUg1choN2VLPQjRx4iLadaOIPPlWAq7XP9eTBQe//I=;
        b=CAppJzXpEt9wDBiyVbDsxWU9975MMYMOgaqdlhrMR7ll5LJq6YECE1YCoyxq/GLSNt
         gkKZRDleT8On8tKrb6ztIknnIUJ5F44vM9VNMa3o6/3EJ28KFfEIOV8MeqDuZVvYVohN
         ay7CmOZc8Jqu6xNIWu+tjNh4ZS2Wyj+YG7+DpFJ8G+ETPiy+CFjtHJjy2nPPssC44GPm
         fxaVxQ4ljMD24f7E92u+SfP0eQwAyZ1gpeJfi3AD01WIQqOW2f2qzYynVqmN4wg5KH+5
         zMFSUJOQbae2cAZzzG+bQED7yySZntnzvi2fUNhOFNYg0aG9Vn3Jq7ivO3np+I83gysp
         6dOw==
X-Gm-Message-State: ANoB5pkPn9q97hJyhs6brd7It59aKdRQ2onXjXt12Nm6h3S34hurYxa+
        pB0UrGtLmhlqP3CJcReN+jRnmyfqtf+E1BgCErk=
X-Google-Smtp-Source: AA0mqf6tOmvAwiE4J8oX65FicHt2FCQYERLBkTg4NDn06W07EIaFS/pFT55OKnYT1H4vSyDQVWvX9fRp69ZvjDCScwo=
X-Received: by 2002:a63:7cd:0:b0:479:eb5:a51 with SMTP id 196-20020a6307cd000000b004790eb50a51mr2971227pgh.209.1670983367797;
 Tue, 13 Dec 2022 18:02:47 -0800 (PST)
MIME-Version: 1.0
References: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
 <CALV6CNPysKmTDmeZds61eKrtmA-yGbj1pQKvxOtfkpF3P5ankw@mail.gmail.com> <9CCA3C67-3A27-42BA-93D1-7665A051F485@oracle.com>
In-Reply-To: <9CCA3C67-3A27-42BA-93D1-7665A051F485@oracle.com>
From:   Xingyuan Mo <hdthky0@gmail.com>
Date:   Wed, 14 Dec 2022 10:02:36 +0800
Message-ID: <CALV6CNOp_pV_bscxsqMFGdPSRaL_aB0JkzRrNbr3Qa813kjPaQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 13, 2022 at 10:02 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> May I add "Tested-by: Xingyuan Mo <hdthky0@gmail.com>" to Dai's patch ?

Sure.

Regards,
Xingyuan Mo
