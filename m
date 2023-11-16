Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F887EDBCD
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 08:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjKPHL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 02:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPHL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 02:11:57 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF8199
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 23:11:53 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b2f28caab9so311475b6e.1
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 23:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700118713; x=1700723513; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YyYlPJ0DDpeEInnpMb8OrHzvYzKIqqHijPIbsicGglQ=;
        b=OVTh52UVTiay7XhPG0TFIGXpHXnWg52osTOfBpxn6XbmglsmacwRNAYVk3ayUtoaOY
         9yhZIXzEVeil5YXIzXKuunmGOHTnxzU04hL2EWMG3ASHSkCSMChnf9NBZeZvW+eIgW9Q
         biiU/nWDt4oLmmuO9VMkVD+FDrMaF/koZldkvSlrjVOH9dCpdHWcuOkaznCh2TwzZ5ye
         pRy9CYzGrgf1Ufj+RDTHAXwFt7DwEPXVa8Lef+6CmOuxVsJ++QZEs7KzB78CAQYd69o9
         qyP+oXfP0SAcbBxwEae20KLBFbpcyazxrP+k75H/GwzPy1ikYeCYyU8TWvss0RyyYE8v
         +AnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700118713; x=1700723513;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyYlPJ0DDpeEInnpMb8OrHzvYzKIqqHijPIbsicGglQ=;
        b=LV0cCgEfCqHO4MjkFANZuHXPEUD1eHE7KMpf9clyuYSABInJyj5Q4c+dFQ/LM/vUfv
         XUBO1fMV7F3X8eJHI3jb//K6RHgBor1qfxzZRedvzxQBDlm5PGKjDbEGpuTIcEEuUUKd
         RU08I0FNRU11Cp35WmeNyjyfqKIwsjsgnFoBgMIldsP43FMk9Fux0GFkNIJNLg4avGc+
         FdWmJaB7+FZ8l3lFSmFjDWLv5XtmcqL3OhTMEm3Nndv0l6gLNG8CjG7VZZdQ+bl5U4e8
         wuq0hhVhuPII4bRplZnVCEVvZMZKF9PTzAGQMvZphs7GMw3z2VcCKU5pssqqBLkxng3y
         z16A==
X-Gm-Message-State: AOJu0Ywo9x/joXHu+IhkaCeVZgBIBuFTwWHLkYtBqU3aiTlt6j0OLYLM
        xBdbhvtV3IixD3+GY/IoNzQf5lfuvCWfeyfQeq4/ok9kmo4=
X-Google-Smtp-Source: AGHT+IGZ94P+6JSsOOHa4ZF/60sKbRAhwZrp/TFf8PZVvRHp8FCH981xfox+bTsoa/AnyX3jp/gdKukfngP/tQGuViI=
X-Received: by 2002:a05:6871:a589:b0:1d5:a17e:f62 with SMTP id
 wd9-20020a056871a58900b001d5a17e0f62mr17500284oab.24.1700118712968; Wed, 15
 Nov 2023 23:11:52 -0800 (PST)
MIME-Version: 1.0
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Thu, 16 Nov 2023 08:11:42 +0100
Message-ID: <CANH4o6PU1p6NzS3X6ohGFPjzxKXr3gXn70s-VV+HSzAAPbWyvQ@mail.gmail.com>
Subject: Does NFSv4 close-to-open consistency work with server "async" mount open?
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

Hello,

Does NFSv4 close-to-open consistency on the client work with server
"async" mount open?

We see several build errors here with parallel GNU Makefile update,
where one process writes a file, exists, and the next process doesn't
see all data (linker ar: file too short).
But if you manually look at it the files are OK, and completely written.

What is this? NFSv4 client bug, NFSv4 server bug, admin error (async
breaking close-to-open consistency?

Also, is close-to-open consistency guaranteed between different NFSv4 clients?

Thanks,
Martin
