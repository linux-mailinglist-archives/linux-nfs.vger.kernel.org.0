Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287CB6CD1CE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Mar 2023 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjC2FsR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Mar 2023 01:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjC2FsQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Mar 2023 01:48:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9DF2113
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 22:48:14 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 571643F231
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 05:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680068892;
        bh=BZ7Jtujotm4llFlANUu9WT13QRodHexCWK1fgXuPjbc=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=GfSet2c4+XjN6CirIs++aEzT1C2cxJ/CpjQWt7QysASQn6wNyc/2aCdnourIQZtrb
         uKENpVdb8DdvVLe2c4kvgZkzCxBAYFEN8Z7yJscKZKAIxOzzsdx2zkFbnqqyHcNlGa
         7Xs4jYaSYOWjZD97B55ABZF60bYZlGbZMfbHE/wKttc0G68QQ+rZcnViU+xcoz+AZf
         xHYI2tkTWtAkSqLwSfagWMp5W+SA8AjFumWjTerB+t/uWp/ngAI4dL6OJ/cD7g0F31
         vrVPwMR2Hp7Yx2wcoWWqby0iRtYl9exZ/6pFKr3eIsQYUqbH3YJUKNqwPINQQjZaOO
         3VUfVHS9cieJg==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-544781e30easo142765687b3.1
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 22:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680068891;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZ7Jtujotm4llFlANUu9WT13QRodHexCWK1fgXuPjbc=;
        b=a0QJEoYVYK8NRaHlGfcly62qhXSZCLuWGeDUf4A+17W2yaGMqDjNlrja8qt7IXYawY
         2vMSod14OTA0eZLZtrWtTuudbbsqYJsPUYxchHd+MWfMXm61OhqRUUAazWrJ5Hn3Ng1d
         bPdXGVWjyrqmjg/uoI2VC8iuJrHoRT1yk4Ir7j/tA8wvzBk+Og5IooSFpiNVwrwfrQPK
         TC7yI/hyWOi6E/qu0N2Q6ui79g1HszzA0F1SGRKo/NXLPwTs+MZWo9r5haHyzOfjDLLS
         XLnTPfL8mkNgMSjH0hi1WaqaGRissICjvfNvF/O1o7lMjxO/HPHHIzkhqskD7xAbbwW5
         2nhA==
X-Gm-Message-State: AAQBX9dnlXmGFSEpnWXv7IE07Pdqt9mEhPPsiUnhpe2x+VSdL9fksM+y
        /OxzQF2/05oNuaQv1+t/AI8yzeWpbxW14IpqwB2S4sQDUs/W6DwhC6AiY7EmQkGADYgtSs3aky1
        bdxMO/cnTUWNGxoawKDkHJbOHbglDzJCU9tkKbzehQBbF+ThepH5oLbeXNzVOjFjK
X-Received: by 2002:a05:6902:1024:b0:b77:3f5a:8a53 with SMTP id x4-20020a056902102400b00b773f5a8a53mr8832356ybt.12.1680068890866;
        Tue, 28 Mar 2023 22:48:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350b4bpSeCcdrg8rlxqorVyiXKRMBh+uD0Ei5AkqfJO2UpZBDu+hoPiOhrZlGRty7+IpB0PFaccH1yGWyTDhccbw=
X-Received: by 2002:a05:6902:1024:b0:b77:3f5a:8a53 with SMTP id
 x4-20020a056902102400b00b773f5a8a53mr8832343ybt.12.1680068890644; Tue, 28 Mar
 2023 22:48:10 -0700 (PDT)
MIME-Version: 1.0
From:   Chengen Du <chengen.du@canonical.com>
Date:   Wed, 29 Mar 2023 13:48:00 +0800
Message-ID: <CAPza5qfD9_1CziYjBsbjt1BTJwVKvEJvi5sOdtYYKG5vHeM52w@mail.gmail.com>
Subject: [NFS] Performance degradation due to commit 0eb43812c027 (NFS: Clear
 the file access cache upon login)
To:     trond.myklebust@hammerspace.com, Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond / Anna,

I wanted to provide you with additional feedback regarding the
performance issue that was addressed in commit 21fd9e8700de (NFS:
Correct timing for assigning access cache timestamp).
I apologize for reaching out to you frequently, but I believe this
information is important to share.

Although the commit appears to have resolved the issue, I have
received reports from some community users who are experiencing a
significant increase in NFS ACCESS operations.
If you are interested, you can find further details regarding this
feedback here: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2009325

After conducting a survey, I have discovered that this issue may be
attributed to suexec-like mechanisms.
Specifically, applications or users may use the 'su' command to switch
to other privileged users and operate on NFS-mounted folders.
In these instances, the login time will be renewed, and NFS ACCESS
operations will need to be resent.

While I believe the new mechanism adheres to POSIX design and the
performance overhead seems reasonable,
I think it would be beneficial to provide a mount option that allows
users to decide whether to renew access cache after login.
In some production environments where access cache can be trusted due
to the stable group membership, this option could be particularly
useful.

In my humble opinion, the option could be enabled by default for most
personal users who can afford the overhead.
However, I am open to hearing your thoughts on this approach or any
alternative ideas you may have.
I would be willing to contribute to this effort if there is an opportunity.

Thank you for your time and consideration.

Best regards,
Chengen Du
