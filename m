Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFD57BEEE
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jul 2022 22:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiGTUB5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jul 2022 16:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGTUB4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jul 2022 16:01:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4297419A0
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 13:01:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e28so32007842lfj.4
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0PjadjtjZhNmKnJnHqCOGZdCzVxYykgNGxR63blwMuc=;
        b=PRZcGNGD2IVQGVsCfWadW8yWpUHwq/RDO8M4XvRs8Htci2xa8EchvhE9tM5pEU4dPQ
         FluTljvz1mr6ArCOWsAysEyZuArkbUOJ6aPzZdzJsYWGE9pCB2rjEpAH0nK9xCKbAEsn
         lxXzK8ocCkNgOwPG9zhBlxsjfgihEK9Ko1hZOWh1bniHZVo+YPMdvikSss2tZv8+JCW2
         GfNumM61i7rGdjF2xoOhzx7OKKOyrp7Jmd8lny/SOPvC3m+JIK5q8g6neHcZsuNLmtHr
         YCiQ7+ApV2u8yj8D4jiBJE6VnWCfHQ/tTScBA1dIwAIEWAkrQCIfV7IrhfuI3YPtehMg
         hQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0PjadjtjZhNmKnJnHqCOGZdCzVxYykgNGxR63blwMuc=;
        b=hYOFD6wf8tpXQf65VAh+HbYc+GKykFwNNUuudrxAtm82hiHddI9IXlcRQwqT5iNJxt
         +kM8GEjvo1VLgl05eQq4rPYBu5FH+exoXH+WJjt/OHZIl65PkKntItFtLvkSIqpk5OF3
         tyW1IC2E0/zwSMK8NF/pvvdiACrTc0ZviWGENL+gELyFCy+kZZvJEpWgKY72R3Idb5bJ
         YeDcvFhTRV+dVfz4ftoj9HKRltMHXTuTxC46VvaNP4i6DPxEZxKMujKlxxwRocCIZXkl
         dbso+5LlnMsCWcHnyLjW+XTaSJ9B89m0H0+5rS3bA96i24uyai3uQ2aznYJOqubTiEC+
         x48A==
X-Gm-Message-State: AJIora9WfW+qkOlcDNj3eVA3v9Wo+6uhsyZRNVbA5AohvyVIjRvaYMGB
        kyJhE517M1IR7sVi719IprtrPut2ry/ps0tJvMnGxh3vIyQ=
X-Google-Smtp-Source: AGRyM1sd56Z4iB4ErER/9zltECEeDTcgduXCNEE6L8Agq8wQtpV9f5r7drAQ/aNryI2qt6i05+XYmr6SJHjecoN4tgQ=
X-Received: by 2002:a05:6512:3d06:b0:489:d0c2:649 with SMTP id
 d6-20020a0565123d0600b00489d0c20649mr21931794lfv.210.1658347313870; Wed, 20
 Jul 2022 13:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAD15GZd=sxsXiNmuN-FpRk3E_cKRF_CTLqxd5XJ4KhtON4XkPQ@mail.gmail.com>
In-Reply-To: <CAD15GZd=sxsXiNmuN-FpRk3E_cKRF_CTLqxd5XJ4KhtON4XkPQ@mail.gmail.com>
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Wed, 20 Jul 2022 16:01:42 -0400
Message-ID: <CAD15GZe1__nJ6SfAr1zs4Vq4za9D=FP__SotyS37RVh=2OWu-g@mail.gmail.com>
Subject: Re: NLM 4 Infinite Loop Bug
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying two commits from the Linux master branch seems to have fixed
the problem:

aec158242b87a43d83322e99bc71ab4428e5ab79
1197eb5906a5464dbaea24cac296dfc38499cc00

-Jan

On Wed, Jul 20, 2022 at 2:46 PM Jan Kasiak <j.kasiak@gmail.com> wrote:
>
> Hi all,
>
> I'm writing my own NFS client, and while trying to test it, I've come
> across a way to get the lockd thread into an infinite loop and stop
> accepting any new requests.
>
> Kernel Version: Linux ubuntu-jammy 5.15.0-41-generic
>
> The client is a python program, and it does not run rpcbind, NLM, etc...
>
> I issue an NM_LOCK (procedure 22) request with block set to false, and
> get a GRANTED reply.
>
> I then issue a FREE_ALL (procedure 23) request, and the lockd thread
> gets stuck in nlm_traverse_locks - it matches the host, calls
> nlm_unlock_files, and then jumps to the again label, and repeats this
> loop forever.
>
> It's not clear to me who is supposed to unset the host from the lock?
> Any pointers as to why there is a jump to again?
>
> Thanks,
> -Jan
