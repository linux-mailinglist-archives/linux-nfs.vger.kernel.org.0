Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14EE7EECE3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 08:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjKQHnN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 02:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjKQHnM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 02:43:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BA292
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 23:43:09 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso2408772a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 23:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700206987; x=1700811787; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQKfcERnVTM0q4qNxTShaS+QT9UahE9ULC95er4qhYE=;
        b=FuU+rK6ctW5S2yMiwrQ5LPOfTS2y17Y2Q+kFGoy2nkovjRIOn3if58Mpg2XI0RQuf6
         rj1GOaunEJsdGwqrL02IODKnzC/ChPtI9kCXMcWQJp5EzcjxZdI+E4bTNxEU/m11Uv4/
         GjzjlqaOSut4VJGwviRP9xmfcn5jz6nk/JOA9i5JV3jcopKhNsyi54yKYI8nlAbimsLv
         FYBCbo7dNFMa0Tn6z3apSp91IAt2E+ERIU6ZDRYTR6/3MHF8YHXv8e8OD11touDNMmZn
         uUt2PSKXDUapLGNavz4s/uM7K1fEP2B2jm/IqB4NpI0WNxGveO77oAtcz08esxPelWHQ
         I/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700206987; x=1700811787;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQKfcERnVTM0q4qNxTShaS+QT9UahE9ULC95er4qhYE=;
        b=loQcYcG8ae+YU1v8TlPCSFn3kooPqxj10WO2GzbpICHdb+QYO42u4WM+jZHhGUhiid
         Yq9SJzal6iONCCRHcHh+I+xi3flKl7ilWPyWd/JYRGY9Vcnx0pQq3fs0/hG8jx/Ku0g1
         KLlXIeKRpt7rn/Eo1AHlTTayKvvHAmLUJdhIblf6CpVmcb7Iggq6M01xZZ1z14MGvdOq
         rZ5FIqtendJ2fPCH7BWX3osQ/RAMOqqDu5DDHeB+fvfStw54AKqmMoeXQ2tcNGDLeY5x
         wTOnwJZGhTVsMd1gwNhVQ9gP8YQjYPyysEFw9kcA4az20s4gu+zI2WUWbkuF8vD7wZ7w
         J0nQ==
X-Gm-Message-State: AOJu0Yy4SKDUwpV14naT4hxzDHoZXF/m+NuFYXXVf7SWd3lnbfYstbbl
        Ob+FjTVWcFJqDgu51k9+Rf07y+sOCeBrBcxLV2FMrFaCwiI=
X-Google-Smtp-Source: AGHT+IGTkYuvwwz50CmN0P0EYcXKzuYubt9MiQODJdYGm2/mXWcB1vxNXGPcnuDZpDJ9F9eXIXtpSI6ZWLiQMaB8s40=
X-Received: by 2002:aa7:d3d1:0:b0:53f:23eb:24c8 with SMTP id
 o17-20020aa7d3d1000000b0053f23eb24c8mr11531622edr.40.1700206987440; Thu, 16
 Nov 2023 23:43:07 -0800 (PST)
MIME-Version: 1.0
References: <bug-218138-226593@https.bugzilla.kernel.org/> <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Fri, 17 Nov 2023 08:42:31 +0100
Message-ID: <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
Subject: How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals -
 no way to define custom (non-2049) port numbers for referrals
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

How owns bugzilla.linux-nfs.org?

Ced

---------- Forwarded message ---------
From: <bugzilla-daemon@kernel.org>
Date: Fri, 17 Nov 2023 at 08:41
Subject: [Bug 218138] NFSv4 referrals - no way to define custom
(non-2049) port numbers for referrals
To: <cedric.blancher@gmail.com>


https://bugzilla.kernel.org/show_bug.cgi?id=218138

--- Comment #2 from Cedric Blancher (cedric.blancher@gmail.com) ---
I cannot access bugzilla.linux-nfs.org, it it does not send a "account
verification token email" to me.

--
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You reported the bug.


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
