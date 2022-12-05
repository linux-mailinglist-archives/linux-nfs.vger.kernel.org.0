Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2275B6422CE
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Dec 2022 06:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiLEFoU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Dec 2022 00:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiLEFoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Dec 2022 00:44:19 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983056400
        for <linux-nfs@vger.kernel.org>; Sun,  4 Dec 2022 21:44:18 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-14449b7814bso7340894fac.3
        for <linux-nfs@vger.kernel.org>; Sun, 04 Dec 2022 21:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wMq2tf2ShcsNl+2tdhGNSD1zJfbMMgZKuh64RqXis70=;
        b=HMEOq0paowfg15cOBn/I51q5Db4h+QbKKHDl9ikzS4HwT9TDv+ZpiR4rXcHA5Th5Lp
         DgYMFJBBpN0fnoVeusSBPNkakF48m7h2iLfWvo1P6VVGlkq5jmGmVqAwYRtbGdiU7tZ1
         SADyJCQ3dd9KZ+qV26B7zJL7/QsVjFaEWLEAEMj+go/SAsKFC9RMVmC3K19Uu8YNzXqp
         aVXgJyIApgPlW4SduWqnrYjI80AKPB5/3bYr3qufnMWWERjBfBAjuT2mz9v9X0vTZ8FZ
         aD6LbxQzERXJEuloYbXV9SBVRdmupfg347ZIYkb65tRtu4Lqq/XyEHrE2Ogn2qVshHhW
         YDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMq2tf2ShcsNl+2tdhGNSD1zJfbMMgZKuh64RqXis70=;
        b=ZzJSd7MiWNTvVawkTHNYNu0qxcuqcTLplxzK7e/2qs6DVdfpusBhXdCqbC0IMlS79c
         imQCnT8LICm31Pg+wrKapZ1jDuX3HwaOee6EQNVH+dapq0SxYCY1e8TXhcLzjE7O4HdQ
         NGsHlvu8ch+/VcmoSWRn8CQ9OG/0LrGzqaguR8YJyh8HcNEoRthM8rlcY3elOoetwyNP
         k8ejVXRdPkK0DL3LuhobJduwr2NzI1sK4NwnvaHk2kMOpiD6D3MvOz9e9qEnLaNpDSJk
         WfpkALZz02DKa4Q6gtlmc7/UPU5Y7oZ0ZsfFxSy+Uioidu2t7wuqD/Dos3HQnXC2fAxk
         rEWw==
X-Gm-Message-State: ANoB5pmrd6qHBq6K3e2leN4Gtf+kzpVTEHNGZCkkoflccTHyysBAIKLf
        IVDxp4c8pSZt1asvXHeJeJUIueizyJ+qowM8ENFsgLinwXE1dA==
X-Google-Smtp-Source: AA0mqf69wTV06ZwQ2YECks+Jq1aTnoC+VMW8cjyRPc3Ldlhp/iEOd0pgnV+pk9+khcbdCSUXbBBt9Nr3NJqTDJlcBW4=
X-Received: by 2002:a05:6870:c352:b0:132:d3f8:bad4 with SMTP id
 e18-20020a056870c35200b00132d3f8bad4mr37442553oak.58.1670219057775; Sun, 04
 Dec 2022 21:44:17 -0800 (PST)
MIME-Version: 1.0
From:   Jidong Xiao <jidong.xiao@gmail.com>
Date:   Sun, 4 Dec 2022 22:44:07 -0700
Message-ID: <CAG4AFWYGYtYOoi8BuFos__GSNrLVXBwcaDpVR0D6fRv3ibPkmA@mail.gmail.com>
Subject: Is Linux NFS block size 512 bytes or is this a bug?
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I saw this line in fs/nfsd/nfs3xdr.c:

/* used */
p = xdr_encode_hyper(p, ((u64)stat->blocks) << 9);

It seems we are left-shifting the blocks 9 bits, to get the number of
bytes used. Is this a bug or we know the block size is always 512
bytes?

-Jidong
