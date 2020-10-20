Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4436294300
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Oct 2020 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438115AbgJTTdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Oct 2020 15:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391043AbgJTTdj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Oct 2020 15:33:39 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD8C0613CE
        for <linux-nfs@vger.kernel.org>; Tue, 20 Oct 2020 12:33:37 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p15so64828ioh.0
        for <linux-nfs@vger.kernel.org>; Tue, 20 Oct 2020 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ilm.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=gJDJfuMD9XDxRFzHFrZpXL2DuJmt8k2Dbu6HQVLojOg=;
        b=VFwQpVxNJDJN2i2QgSUeyd/kl7sWzeMVPkFXXRUwATBieZQJ0YUQFwRXPt0zpnhmCQ
         34ITVmc1Hj9Tu4gKu8LvK/yKTDPJEdBELuxw+1WAZaZ1FZN37zHK3GuOjAhcMo6oOM91
         yxCKtNP92+WlXG6g3EMFGXZjyfjC0pXQQ/6RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gJDJfuMD9XDxRFzHFrZpXL2DuJmt8k2Dbu6HQVLojOg=;
        b=LrmC//lOeruuS5BEg6R8CWBClN5AMpUp62PLd4hhLTJhFI9/p7vmSFLRedG7HzZmJ6
         +T5zAFdbSbBuSgCEyYhEb/6mNhla/iJjqJbKRkubYiZq7ucssC0Pbz1LLgYCmAYh4Hro
         Qyfe5EoryZN0uRt770IjDPw6jHri1/IPQb/aKQo2cEuCjCtExsvyuOdJbBT5F1ICUMKZ
         /XKdmYjllehAWLqSeJx5L0p2QCEuX1d77uglTVzdbci4xLlvIbF8KqDOquuWLxlx/xoo
         p11cLJ3qaF4oJjoksvCNZsNoP2AKtIx3FigJyfLFHT9KEhwGaTCXvmI/6Fqw79T3R8fP
         bRJg==
X-Gm-Message-State: AOAM532SwQI4/y/d/VVisSuHFzszQCSim0pVH7dsmVWMDNJtQ8xdFua6
        hm+JCBt328ztGhcve28UZ+hZ0BcIwelw11FE0IfsYMv9TI0=
X-Google-Smtp-Source: ABdhPJwuThtL9elIf6O6kidOsi8YvMz+65ME6XBmfkbkqDuwWEHxR91CnBGFY9eteQcY+E44cw9RkaBCeGtMOohNaAo=
X-Received: by 2002:a02:3b57:: with SMTP id i23mr3521569jaf.110.1603222416828;
 Tue, 20 Oct 2020 12:33:36 -0700 (PDT)
MIME-Version: 1.0
From:   James Vanns <jvanns@ilm.com>
Date:   Tue, 20 Oct 2020 20:33:26 +0100
Message-ID: <CAH7vdhOegDeCS6t8mRr6PgoyaUS4u-Y7tn1vkY9010ByxPg2Xw@mail.gmail.com>
Subject: 
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
Jim Vanns
Senior Production Engineer
Industrial Light & Magic, London
