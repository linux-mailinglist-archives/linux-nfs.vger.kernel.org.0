Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92367C94B0
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Oct 2023 15:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjJNNIt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Oct 2023 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJNNIt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Oct 2023 09:08:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081DD6
        for <linux-nfs@vger.kernel.org>; Sat, 14 Oct 2023 06:08:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so5056351a12.0
        for <linux-nfs@vger.kernel.org>; Sat, 14 Oct 2023 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697288926; x=1697893726; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/ejzYnRfTLsiAuUMTkdBy5vZBno72m8msVDG2NIKuQ=;
        b=YxjTe4vYpOxnHWcoFJUSfjyR7yUIgEPzhYh7CFwlOf/LZnoJxdi+5hc3Hat/xG4zO9
         lcSD+dMPol975woNy8yZOcez6abyjTgoI1KM8S++nLkLQOF8zN4M1x1cESHZ8B2U+wvP
         O/7Ymh0Eu7aVbeULFCMw1hdXZK9EjNaIVpaHvBWdlaqGtRlv8N9j7lvadfSOSfXjJm1N
         Kqoe/J1lUY8gmrT0j077H/7w1PRk5oezj/i1D4oV/Nk/lhQKf8R1DlzGzVKyEvcH9kH7
         ABsTSaufG1eHFUTrLpcEjTKi6n9XT93/dWri8Nw+r9xLBPA9ZqUDPt/Jf8oFOeK4f4nx
         upHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697288926; x=1697893726;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/ejzYnRfTLsiAuUMTkdBy5vZBno72m8msVDG2NIKuQ=;
        b=nRxK+AUBIthLyZaXcJnCZSRvjEseE0IGpKT9oT2PeO508qhaz9xxYsU7trsNN+HuuA
         3s7ndO+4lvvlXt21rbQVPTFO4lBQ5bnfoiD0Ny51Fx8YN6GnEtfA/isQA00EKf71RHxd
         /LWyeQKR99eSzg4R3IIV2Wh5EGxA88BTddFwvEsqdrKX16CmG0LApfLLr1nDBxmI1DhC
         ZZkjN5lKTLbjU9PDHAwwu+axD9ypCLUt5sld2z+vaAAFLth0ITpoZVnYkQaVYRGUvKfi
         NsS11xG+Mc2WZy/L0TJUGrTR0Md87qrA4KiR+5DoGVikCju8JfZ6e0yAlYi1P//kSoiU
         WRoQ==
X-Gm-Message-State: AOJu0YxlziQiG9SZSD/acq9s/kvgm9gLzvkIm3LGZbVEck4754tQjp3Z
        OANYzCB8UNd9rP5XQlkOEJ03exmlcLd8wbq8fJks6LV3
X-Google-Smtp-Source: AGHT+IHOw9x8S+UPYoU9Lw0i+OPTV0kd5yJ5Kqo0aQ+W8gA7hpRUq+Sm3QglNZ//LL3efpwGxNxXygKWQa56kjzzte0=
X-Received: by 2002:a50:c35c:0:b0:533:ccec:552 with SMTP id
 q28-20020a50c35c000000b00533ccec0552mr2125914edb.9.1697288925742; Sat, 14 Oct
 2023 06:08:45 -0700 (PDT)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sat, 14 Oct 2023 15:08:09 +0200
Message-ID: <CALXu0Ufzu8FMdH=-_35tHNqu3c6ewf4d6a379=fUMwNvGq_rgQ@mail.gmail.com>
Subject: NFSv4.2: READ_PLUS - when safe to use?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good afternoon!

Since which kernel versions (NFS server, NFS client) is NFSv4.2
READ_PLUS safely usable?

Also, could you make this a mount option, so people can turn this
on/off per mount, instead of using a kernel build option for this?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
