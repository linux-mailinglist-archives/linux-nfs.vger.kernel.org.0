Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414866D8DC5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 04:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjDFC4e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 22:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjDFC4Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 22:56:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE1B3
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 19:56:00 -0700 (PDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4E7573F20A
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 02:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680749758;
        bh=yd4nOb4A8S0cIwUdQixaUvZic+AC6Ir3/vF0pHmrh8k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=e6V6DKLW6JewSQkm0bGuJwHNZAG9iAi0gKLgW7FjqTNNLD1g1Npc63PH9wsv4qSB6
         sVq3BMAtv6EmyBeERM3wBi3IJ8d1lOfht+nAr2a5/dVdm7C2grTZLj/PX8LkKzlJMo
         kUsGQaWbaAi6cGDXhJER8gKdfHyt1GXAbPTJ/uHDBlArMAX4Zai4y93PBEhfzeWE6y
         mk74WMs+tJhmZJXFc7CcbttzWIlMuppNZAXYg6lIaeo1KF1611FrSBWzszLLfCcDq0
         pJf4qx+bgGVwT59cVoqF85lC4Vc6i1mi6lU2tnwyPiCt1RWlNCbmSEHC43+TWLRuWr
         J7CINHvNdlZsQ==
Received: by mail-yb1-f200.google.com with SMTP id i11-20020a256d0b000000b0086349255277so37650782ybc.8
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 19:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680749757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd4nOb4A8S0cIwUdQixaUvZic+AC6Ir3/vF0pHmrh8k=;
        b=1AdkXLTNoqd+jI2S1aQltWp04Kb/eUhkmpJgWxh3ruK3444igoQRUiGZW0L4iwaSNf
         aEqyRhTsI0ebo4tdWU8rYi5x7U8NKt4IJjts2s/FeulHuotW9TEvy2tBWTJi2AreHF7u
         p2Vyc28DF0F65MH8Y59YQ6QIcd4elV9Z92ikBC1qkCBMERi6kRRmNKuLCZM/4YEutvX4
         6RHQgr8BKTvJGFchUfYpGtvRe+yYLJ3OOaYFdrbu0YC/npGk0V42rfloeMa5lmp322fA
         ZBuXyJhbPwTl0AIaj6wW1BYadoLJUvNnKGXOX22VbuDr2i3vHb49zeDXRY7wsL9pAfqu
         lzHQ==
X-Gm-Message-State: AAQBX9c66pvihP+FAsxjX8w/il59iCDxLnpVTUNtiOVXqklz/nojnlJz
        uN86DfGhAkw99HPrhGfw0yZRsLA00kA4N104fjMwi6nOLLU88HZqQPLGI6L7JpfEE9KgyC7TzhU
        2riMlW7krMdjOE8knRd0Xc26gxC4yEvK3Ho6JiaQbY+GZypjvmBFuYQ==
X-Received: by 2002:a25:d711:0:b0:b7c:1144:a708 with SMTP id o17-20020a25d711000000b00b7c1144a708mr1067081ybg.12.1680749757318;
        Wed, 05 Apr 2023 19:55:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZOwKRFRodZEJks3GoreNWJCtuH4+vl+P10VftZ1lhAthbt77ywOzYRo6jAE5etVl2TULPo2/yt3zYAOSpb6fU=
X-Received: by 2002:a25:d711:0:b0:b7c:1144:a708 with SMTP id
 o17-20020a25d711000000b00b7c1144a708mr1067074ybg.12.1680749757044; Wed, 05
 Apr 2023 19:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPza5qfD9_1CziYjBsbjt1BTJwVKvEJvi5sOdtYYKG5vHeM52w@mail.gmail.com>
In-Reply-To: <CAPza5qfD9_1CziYjBsbjt1BTJwVKvEJvi5sOdtYYKG5vHeM52w@mail.gmail.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Thu, 6 Apr 2023 10:55:46 +0800
Message-ID: <CAPza5qdyedpqdZYA3spd_L4v2goJbnjOqdu6TZuZ3qXXkqgCaA@mail.gmail.com>
Subject: Re: [NFS] Performance degradation due to commit 0eb43812c027 (NFS:
 Clear the file access cache upon login)
To:     trond.myklebust@hammerspace.com, Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond / Anna,

I apologize for disturbing you, as I understand that you may be
occupied with other tasks.
However, I wanted to bring to your attention that several users have
reported a performance issue, and are eagerly awaiting a possible
solution.

I have proposed a potential solution and I would be grateful if you
could provide me with some feedback.
Your input would be highly appreciated, as it will allow me to
continue working on this issue and finding a resolution for our users.

Thank you for your time and consideration.

Best regards,
Chengen Du

On Wed, Mar 29, 2023 at 1:48=E2=80=AFPM Chengen Du <chengen.du@canonical.co=
m> wrote:
>
> Hi Trond / Anna,
>
> I wanted to provide you with additional feedback regarding the
> performance issue that was addressed in commit 21fd9e8700de (NFS:
> Correct timing for assigning access cache timestamp).
> I apologize for reaching out to you frequently, but I believe this
> information is important to share.
>
> Although the commit appears to have resolved the issue, I have
> received reports from some community users who are experiencing a
> significant increase in NFS ACCESS operations.
> If you are interested, you can find further details regarding this
> feedback here: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/20093=
25
>
> After conducting a survey, I have discovered that this issue may be
> attributed to suexec-like mechanisms.
> Specifically, applications or users may use the 'su' command to switch
> to other privileged users and operate on NFS-mounted folders.
> In these instances, the login time will be renewed, and NFS ACCESS
> operations will need to be resent.
>
> While I believe the new mechanism adheres to POSIX design and the
> performance overhead seems reasonable,
> I think it would be beneficial to provide a mount option that allows
> users to decide whether to renew access cache after login.
> In some production environments where access cache can be trusted due
> to the stable group membership, this option could be particularly
> useful.
>
> In my humble opinion, the option could be enabled by default for most
> personal users who can afford the overhead.
> However, I am open to hearing your thoughts on this approach or any
> alternative ideas you may have.
> I would be willing to contribute to this effort if there is an opportunit=
y.
>
> Thank you for your time and consideration.
>
> Best regards,
> Chengen Du
