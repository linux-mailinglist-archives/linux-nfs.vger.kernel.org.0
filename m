Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2977EFE5C
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 08:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjKRHxv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 02:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKRHxu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 02:53:50 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934F9D5C
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 23:53:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so3994502a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 23:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700294025; x=1700898825; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9yA6k+N2nolr1caIMvGhbkaYv3U+lNj5nZTOLk5PRk=;
        b=F0AEfZ+xAd80a/9zlgYXWSk02p1IARF6M7SHwjmyFTbN6YPEkh8GxRrfLSp2zW26CB
         hcfeOACZBzKAoir7zECF+s7Zn2Mex7zDP7hYw7N1nqh78jgvRGun/qd1o3tzdN3UJXwt
         XT+UVWRTZ8brKwgWhqHDm4Fd+iIyApwm/7qZDVGqm/2fuMxftXhHSdOeeWHTNuylVXVA
         PgzZT5vtuaIbfYvCtMIhM4VI4quQpzZKHPbrKWAV4cRcklMg1C14UerM8q/JDgjoY2p4
         XFap/DkJE3y2j3I4Hw6mmXVmlIY0h+tST8ii88wwVpPEjsbUcesRV2AOBZpG8L5lXGaP
         HRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700294025; x=1700898825;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9yA6k+N2nolr1caIMvGhbkaYv3U+lNj5nZTOLk5PRk=;
        b=p14az2fSuxjei603UV8CajfDzwvRNdJuJ+HRPGNxL7O3PKYvER008YkQZBgk04IVdB
         ZjdZMgORZHdf7hj2oZv8YMjSKFFwdhiXyIkdhXZVEmZPhZ14Mz6HD+69FtQPZ236p1TJ
         MzLrd6liwBHvh/ZJaiV2Ok+C1v1QESG0PX9RXtPp9uO30IRwy+5jW9yT6U8ZN15vSYrg
         b6FUa2EnVnaHi6gjd045scCaWiU4VgubKpcJOpUJQfLaoB2rNBebSi+hNqEeAI1txw3O
         8JBkBY5gRvl/ZixkO5sHg89PUV4hauZkrQy/QRLYhrIFEiIp+cTXaP4S76Fy8JXW++OS
         dFOQ==
X-Gm-Message-State: AOJu0YxUkiSVjGwvozD65foJljDH3Pp8gyo4NjIxHjJAFe/PKI10BZ0v
        h40YU52+ZjhKIq6NmrmVl/8vZX5Gw4J8jp3TuY3B1NYaCkU=
X-Google-Smtp-Source: AGHT+IEI7VGLhYg0sjMxGdE6b89bLN33Q1N4Ywr39FGYBYR5hkP0zPqXIl6Tiq/UEChfYahdeEAOvJi2gRIgte5D//o=
X-Received: by 2002:aa7:c390:0:b0:543:7c3d:6ab0 with SMTP id
 k16-20020aa7c390000000b005437c3d6ab0mr1075408edq.13.1700294025637; Fri, 17
 Nov 2023 23:53:45 -0800 (PST)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sat, 18 Nov 2023 08:53:09 +0100
Message-ID: <CALXu0UcwVRxbG9HD_0U2oK5Le53F3NKQz_H4P4nEesnoWM=BRw@mail.gmail.com>
Subject: NFSv4.1 --> NFSv4.2 client implementation?
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

Good morning!

What are the differences between NFSv4.1 and NFSv4.2 for a NFSv4
client, if we ignore server-side copy and READ_PLUS support?
Can a NFSv4.1 client then identify itself als NFSv4.2 client?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
