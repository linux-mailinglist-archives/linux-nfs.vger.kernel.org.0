Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB9370C323
	for <lists+linux-nfs@lfdr.de>; Mon, 22 May 2023 18:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEVQT6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjEVQTu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 12:19:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0882DB;
        Mon, 22 May 2023 09:19:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f4271185daso62968445e9.2;
        Mon, 22 May 2023 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684772388; x=1687364388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PhyAMTd/xJjXyTngfYfLn7G0uYwXHfcqL/9ZtXOMxUc=;
        b=OaGQZFxaPyPLyNbf9x4KrOMvIfNhls0Fs3WUBtQeEh5dg4KwbXFK5Llbd9izCkI9pp
         pSuneT/KR6uMVP6jBDa/jx9nHhAREsBvtYktGwfy+7ZJz/wSK4n/jPgFmc0QYzMWqCuf
         Yok8PKdQlsacxsxbXDAiAPBfm5LVzBJQuIkt9lob81jiaRlwLiHtVMCrg9TkVikRXaAl
         9ZuEwfxuHJL85bhVPLxQW7lcL9gIx0upwnut/MFq1ejxAMImsI12IDMvH4ivVzeo6drc
         ETYXRvNtfXDpgi2OkCKnghOJBgcUO3unMloaGEUvvCld2D9nP+cemVLchpJIUt2b2RZ5
         4ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772388; x=1687364388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhyAMTd/xJjXyTngfYfLn7G0uYwXHfcqL/9ZtXOMxUc=;
        b=Z5CYLg8rz+7P8I2j3yosVe+UL4H4w2AQWQdvQClRNBrenNpWBCH1RYN9RGhHNmtxnP
         dpsY6xANNqIFRosVwUyPhGiSFyKrZT8aFIF5D9yTVIdqcEypff2OWz25/novJTU+ziAY
         8Ah6CPS8bmI/GHuHg1NwfnyDdBO7rTRTkX43e1nIHsNLg15+1sMUvGvcZC5pkllPYIY/
         EbJiUmNmDUN+rnNdZ/jVu+1BHrjsdUe8itwklNSCQn6fbokuibC1D2JZsQ0hwOzOt5Dx
         jFbGwPmvZMEUywNxsXlkQmP1+1GXan87UPHFM6KLh5n+sITwryIFKMiP4tvgLryS4LUB
         AYlQ==
X-Gm-Message-State: AC+VfDzPc6Bm56fudlrTzMFWGnndqw9Gtn68XHhZOPuGqNYz2NW0VvuH
        b5407xffNWe2jsX86WNWcgX/XREcFqdgxMPOCut35IO7hBw=
X-Google-Smtp-Source: ACHHUZ5GUTRwgVmdoeYEnsyST2Hbq3V4S61UT9WZfdOYWCupqE1j+dpUt34odsLHVBzNmJQneNAQ1zQlryGGrInHap4=
X-Received: by 2002:a05:6000:1a50:b0:307:a77c:c16a with SMTP id
 t16-20020a0560001a5000b00307a77cc16amr8404326wry.29.1684772388080; Mon, 22
 May 2023 09:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230512155749.1356958-1-azeemshaikh38@gmail.com> <202305161403.15ED4EC@keescook>
In-Reply-To: <202305161403.15ED4EC@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Mon, 22 May 2023 12:19:36 -0400
Message-ID: <CADmuW3X1M_j2j=nsx2hM0YO1NeQsrOeb2Z1GOoMAOHCcPozF=A@mail.gmail.com>
Subject: Re: [PATCH] NFS: Prefer strscpy over strlcpy calls
To:     Kees Cook <keescook@chromium.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        linux-hardening@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > ---
> > Note to reviewers: the one case where this patch would modify existing behavior
> > is when strlen(src)==destlen==0. Current behavior returns 0, with this patch it
> > would return -1.
> >
> > Not sure what the implication of this updated behavior would be,
> > so bringing it to your attention.
>
> I'm not sure either, but I would prefer non-terminated strings produce
> an error, which this change does. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Friendly ping.
