Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11E3B699E
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhF1U0b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhF1U02 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 16:26:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DAC061574
        for <linux-nfs@vger.kernel.org>; Mon, 28 Jun 2021 13:24:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o11so18929024ejd.4
        for <linux-nfs@vger.kernel.org>; Mon, 28 Jun 2021 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=1onvlAo6x1M3c84t9iiFsS/HRyy1SWrHlEXnVWCekPM=;
        b=TtM0xt0V6jpJuRXz0xpzhwXkPqKXkEwkKTM+dbwgdNPljraw8zqJ98aTPQNWqGJ+2F
         dESVXOekGksiHbFxbZpcw3gmFq7Sv2QNdtbcBsp4I5vXjIPZ/IIFYF3vA/L772kHpurj
         brxLJZHrEbZNoB/c+uh6kblyLpuz7zqaQSv8UVIOv9R2z30Ogz/4CqQtLXhlD1B6WSaH
         zR7qiRmAPPJg8tn3khafW/3d/5vd4N0U4IrSebb7T2ITv2UvSfGd8Iahj8Z42fFFB8fp
         DFymbzS96VTwQzl8/wEClkYbimZcI0g7vE8Sn4CpF5jIcMxkzkqlMqVLuVZ2DaBK428N
         6qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1onvlAo6x1M3c84t9iiFsS/HRyy1SWrHlEXnVWCekPM=;
        b=p04D9S06c49Cb/IbjXzlxfIa6CxQkPjH+GYwcHSL7M0iD72cW5Vwkgd7WcTSONT4hk
         I7ntASTMocBiuyEzcszDLBmm1cvfJm77+j9CioLEhasvk+cyLOw5RQ+d8DmaYD+dPLyi
         tylJFwp9M5YdcedLZ+NqCm+t9irTp5HVzzSpqxSkfVhbQhBaIcO3mdPrXn7N+/RbM2MK
         1sCAgEVjkkXo63ATgNYjgXh8oYAijjKOmskXDcxtNfoW7NsodXihEteiRWMKXn8xXYrX
         rodP06Z61UAsZ8xnEuW0kYmH3OIryfsH1xnKWmuJSVqkjiUwXKRqM9zco/fIS3G6Wx0H
         6UFA==
X-Gm-Message-State: AOAM532IvdNvqXt3Lju3Wfz9s8ftaotv5gEhG3cU2dUY0ZRKD7vKwiZX
        AxM2gwx4Rl9DMQKjvzaPTgfUzh8otOGdHqVECK1CUynsiyI=
X-Google-Smtp-Source: ABdhPJwMJway9ZwJ5gLEaLzFSklWalD7+65keEzvj1WyKSy5sckmm1uIDWN1QMVwmdqPFwin688c+K7Ji9U0KijiJ0U=
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr18782423ejz.510.1624911838243;
 Mon, 28 Jun 2021 13:23:58 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 28 Jun 2021 16:23:47 -0400
Message-ID: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
Subject: client's caching of server-side capabilities
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

I have a general question of why the client doesn't throw away the
cached server's capabilities on server reboot. Say a client mounted a
server when the server didn't support security_labels, then the server
was rebooted and support was enabled. Client re-establishes its
clientid/session, recovers state, but assumes all the old capabilities
apply. A remount is required to clear old/find new capabilities. The
opposite is true that a capability could be removed (but I'm assuming
that's a less practical example).

I'm curious what are the problems of clearing server capabilities and
rediscovering them on reboot? Is it because a local filesystem could
never have its attributes changed and thus a network file system can't
either?

Thank you.
