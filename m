Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA017F07A6
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 17:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjKSQva (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 11:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjKSQv3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 11:51:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037E12D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 08:51:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so5146561a12.0
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 08:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700412681; x=1701017481; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PP/M4wJQZfNwddnWRuTNmC4AHPQUPyO343/OyqIvP88=;
        b=jlQy3zOm+sE1vYxd1nl/EG9d4r7k6Mdvq8LOqNTMxaQiiawdkNECTnksr6P2ACHOZM
         9tCq/aAj2xBD56srzpYpunZqihgh5mZo4/90UJLhdMXmT6TmXWmkEfF2mnmF+RtRVeHu
         FReSR/CZ5Q4hMBIyqxoWWr+OiXH7HT8yZMzpMsujls0Czxqbl2bcrfMYCC7lFLxPcfmO
         XYYOJpqWfuqID84URQpdw9DGKfDxFCEG+ArVqP2EBp2YsazDGIdOus+62yNuxQdqGUmz
         8PopDKIpRageSKzaagTDXumI3LI4SQ040T2Sqcx0T+aaqpFY2XNPrNwPOUTM9hHm+Hmb
         RNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700412681; x=1701017481;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PP/M4wJQZfNwddnWRuTNmC4AHPQUPyO343/OyqIvP88=;
        b=UW/ytc9BP6GoYmUGHHdvUibI9jSlV1tjdlOe/8yULuYIVTCYywwFPT94EE6RPYlP72
         dSVQcbrmzNf8yMtIvqL1GfCqlM5ljiZKpsTvsxhCC3siqginyUWT1Y24aChsb8/eRsqt
         MKP5yTUIzcvwA4J6nuoH0z4/vEeqzAIU+pugEXQePSZKW/9i1KB02mvrjEHa2/cCKtnd
         I7vQF84z5XNzneJRdYJRDZA7MoSruPGkeEheMyFpJ0YjraRMIkWfsrVNsR5CnbR0D0UD
         mhMV371XKaFISzGOxex9WkuHezeIHcBzxe71+JR+Qss3uW0mqpD2RjK0fgX+y2ytz75i
         x2QQ==
X-Gm-Message-State: AOJu0Yyj22YxBbj3peJlZmMahda/iJlYOtwBo7VjLRfX3ljMakcpzOFF
        RHDxv0S6ySHAIlNSVHctKNAlIMi0bZ2hKAE1RyFU6Mcn
X-Google-Smtp-Source: AGHT+IElKs+IeGBYDX05rDBbqtGf6LAgsghZD9VLAFliX/jm5wrE7DZGOdlPYumQalY4K4YjaflvQ5QvdjwhsVK9qpI=
X-Received: by 2002:aa7:d454:0:b0:53d:bdd2:3d62 with SMTP id
 q20-20020aa7d454000000b0053dbdd23d62mr4062290edr.30.1700412681476; Sun, 19
 Nov 2023 08:51:21 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
In-Reply-To: <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sun, 19 Nov 2023 17:51:00 +0100
Message-ID: <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
Subject: Re: How to set the NFSv4 "HIDDEN" attribute on Linux?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 18 Nov 2023 at 12:56, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sat, 2023-11-18 at 07:24 +0100, Cedric Blancher wrote:
> > Good morning!
> >
> > NFSv4 has a "hidden" filesystem object attribute. How can I set that
> > on a Linux NFSv4 server, or in a filesystem exported on Linux via
> > NFSv4, so that the NFSv4 client gets this attribute for a file?
> >
>
> You can't. RFC 8881 defines that as "TRUE, if the file is considered
> hidden with respect to the Windows API." There is no analogous Linux
> inode attribute.

Can we use setfattr and getfattr to set/get the NFSv4.1 HIDDEN and
ARCHIVE? We have Windows NFSv4 clients (and kofemann/Roland's codebase
supports this), and that means we need to be able to set/get and
backup/restore these flags on the NFSv4 server side.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
