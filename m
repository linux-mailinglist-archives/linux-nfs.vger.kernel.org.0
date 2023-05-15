Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57E37021CD
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 04:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEOClg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 May 2023 22:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjEOClf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 May 2023 22:41:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01723B1;
        Sun, 14 May 2023 19:41:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso8483416f8f.1;
        Sun, 14 May 2023 19:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684118491; x=1686710491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPBclbRVTyZvMbH6a/1lCM5XdcGbDYEnj6EEWEVw3d4=;
        b=JH3yImd4dpC7KzUNRvxIX2XMUnxLGXntyBxk+PaKCfYd5GxK40HEDaRevil5P7xpD1
         NyGhJvD3pcrFONuajdlV2p1PryaQtvRAgWIFUCQybVGE46mBWttPGvfbAns8cW/LlYwj
         d06PqFdJZ2SIi15FNveKR6bqrloInekrHqvP1ueaz5tjZCpij/GMtKOXkITjtNrbTYA3
         glRt2jwPo1yb0iLsqStNudfcaUINVPEyq3eIXj0FRzD14N8Dr3cIY7k1xSg7Cj1bA/YA
         cdg95oAaL/Jr/+HKHTXi8WaZcJjGe4kj/DCqtmWV53Sye1kervER8cguPSk11gd1LUet
         GmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684118491; x=1686710491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPBclbRVTyZvMbH6a/1lCM5XdcGbDYEnj6EEWEVw3d4=;
        b=Z681SUzUmGi9560psORPrIq2Wm0J6eI/ggy8nTOSpceci5BCVBgJYd8ILKnPV7pXmE
         VUpNgXJEK9Bh1kRR7aB8aAb2ClQ+4QJJmYDJieQh/G+LEyxh6Ai6f4mtqxTZhW1Dk0Ib
         y22n+spqxcgJsIkB6leXChykZMo1JVjmdkO/PMitmcqQuf1lIPkZDIs7NjuwqUO35D89
         PG14iLGVnW3QD38I2yxfjhJL5pK0noVcQ2Yixgp8gqwp4CZsT+/gZ0IuWX90JgIXZfEn
         3V3bNwSEt6ecCjoJvmXwtfMysVLvsRK5BSBacV03RJpR6KuBGy2ERH2EysNbSRRABBPq
         Pd1Q==
X-Gm-Message-State: AC+VfDy78/IO/5wlVYe1y7IFNX4L4/4FJivkmDLpGuFRqp05eJ4tIIsW
        RxpUCRAygZK0OiwxHMTBaKJKeScyrOS8933LHYc=
X-Google-Smtp-Source: ACHHUZ4kxMRDXShEr9TL7E4ERrLyCd4MbmyBJxGjQtzEHt76VNt9wI0qb3tKxRo6XvCTxR42nH/2zJWDFOYvxkQ6NR8=
X-Received: by 2002:a5d:4604:0:b0:306:2b1a:32ae with SMTP id
 t4-20020a5d4604000000b003062b1a32aemr22601380wrq.7.1684118491156; Sun, 14 May
 2023 19:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230512145356.396567-1-azeemshaikh38@gmail.com>
 <109A2974-3AE0-48C6-8EE3-FADE95E8EF30@oracle.com> <5E054593-8995-46FF-824E-55B18BF53BE2@oracle.com>
 <CADmuW3UQ-wqobay34PY+myyk1Pr7s-cf7b-U7TUCnarEf+jsxg@mail.gmail.com>
 <A1414FC8-9CE0-4B8C-ABB1-2365E2F62B10@oracle.com> <CADmuW3UkNrSqwQPgZVqRc46hZPK9J6jGYNfU4iS1bQKmEib8bQ@mail.gmail.com>
 <C065205E-54D3-4A72-94A8-EEDE948CB134@oracle.com>
In-Reply-To: <C065205E-54D3-4A72-94A8-EEDE948CB134@oracle.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Sun, 14 May 2023 22:41:19 -0400
Message-ID: <CADmuW3UCOB8YFeZ-y0TMLT74FDJPYzxr=FTPMG1_fZ=LTFpM3g@mail.gmail.com>
Subject: Re: [PATCH v2] NFSD: Remove all occurences of strlcpy
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

>
> Please send v3 along, and I will apply it to nfsd-fixes.
>

Done. Thanks!
