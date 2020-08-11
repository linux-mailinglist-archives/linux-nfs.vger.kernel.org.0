Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E583241F28
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Aug 2020 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgHKR10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Aug 2020 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgHKR1Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Aug 2020 13:27:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6191DC06174A
        for <linux-nfs@vger.kernel.org>; Tue, 11 Aug 2020 10:27:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v22so9681695edy.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Aug 2020 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MG7wQCQdilB4Hz6aKSWGpxx/Ia3KRWGVjDgOrDzBDyA=;
        b=gPqFj49VeOxbXTZpxcd8dcOm6cw1mlDDArlxLom9NMwHcYnhuJ4BnVKp0DDGs83sZ7
         r2KZP6+7spQLNKJEIHctD2Be7Hl+FGw3DLzXS7S5gT2QNXCmeJhTR/XqVc9vidv435md
         UEGGtXY1vhENXG/4inJAks40SK+8WfhfosCNbIprvB5XN7HWqwjhJwtTXznjtqv7rnXN
         BCtHTq5phstBrOFKCkRp+Bfx5xr+9y/r9thivld338NcwZ5S/ycXMgG1i/0zZBpSauPQ
         ecZhT4xwGiibsbOHrMG2To8X6erB5T7WklS2+xpaZcPoufskQBEeTMlK/t2jbFU23LeK
         bHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MG7wQCQdilB4Hz6aKSWGpxx/Ia3KRWGVjDgOrDzBDyA=;
        b=rWMWPWBtPr3RiU+YB9T3nVsCF/XBPt/gsaSPXnG8zmi03p5JgkN/E9Em08o769IRxD
         kWdJXplD9ceZaxscoHJc0urIA2sZQa8eUAe4dASKwaJJ95LbMN/rxVc/kLHSkldSi76C
         lx8HOWTgcKRdh+nJb2xZmLLrr7B7Ck1f4T/8ryO1gvlvm0w2YOH022yNygbKbdTk+Vow
         brhwcXbbITVVz3RaFe09gPR0KQ+rkdA78x2ELyAVyIQWgdECF8OjWL2eJ1Us1isg2pfM
         lDZV63f0NNKM2AX+RBma18D8tVhb7kUn1udB6Fz5yLJZrnNFR0m6r+DDK68d47RjPYv5
         gz/w==
X-Gm-Message-State: AOAM533fmYKDXgdxdXZjcgMl3rEWUkN0OpYVeHWmNbkZjaILw8RtK+Az
        Ym8Cx0pxacq0XdVy1stPLqSUJcWCc06YeC+WzfTcN62r
X-Google-Smtp-Source: ABdhPJzYpV4GPep4wJ/7VptfciL2sKw2MSq7y/xZ0PpQyuih8o948esyekYHjwqkiJ42Nw0cjnQSPVZHk8lR2at5Cmc=
X-Received: by 2002:aa7:d304:: with SMTP id p4mr26085974edq.267.1597166842914;
 Tue, 11 Aug 2020 10:27:22 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 11 Aug 2020 13:27:11 -0400
Message-ID: <CAN-5tyGR0gzAW22pPhzRPtUTnBDEorydgAAE-m_UbjeWfOe-xQ@mail.gmail.com>
Subject: Questions about GETATTRs
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I'd like to discuss a couple of commits that are dealing with GETATTRs.

First is the recent fix in: commit
3a39e778690500066b31fe982d18e2e394d3bce2 "nfs: set invalid blocks
after NFSv4 writes". The fact that CLOSE's GETATTR doesn't query for
available space leads to stale attribute data but marking attributes
invalid instead leads to an additional standalone GETATTR if
attributes are after writing to the file. Question: why not change
CLOSE's GETATTR to query for additional attributes instead?

Another commit I would like to inquire about is: commit
3ecefc9295991eaaad4c67915c6384e5d18cc632 "NFSv4: Don't request
close-to-open attribute when holding a delegation". After this commit
if the client application queries for attributes after writing it
triggers a gettattr (because we didn't get them in the close
compound). I understand that it was an optimization but it leads to an
extra RPC in some workloads so how can we claim that one saving is
better than another?

Thank you for the feedback.
