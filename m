Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5B4594F4
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 19:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbhKVSt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 13:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbhKVSt6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 13:49:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFA1C061574
        for <linux-nfs@vger.kernel.org>; Mon, 22 Nov 2021 10:46:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so80812700edv.1
        for <linux-nfs@vger.kernel.org>; Mon, 22 Nov 2021 10:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iMxvlfVJes5FFeE0X6U3U1fK4vtuWp5d/VgULw7RcSI=;
        b=H6qU3XtBPO2fz/mKcJ6NfFTDIPiWuyxCC4k9oQPTMaixzqkCj45mcl5E4IL7BCZoXO
         YeTkBqsiG+LRRUNAPUrQPUljoFl0jxy7J3EvC3gH1z9E8n7bOGiH8xMD38L6rJL1WZ9K
         2nZiuCXbaeJn4gJyvziEUFkrbhPr7f78fcgemds+1RGIyjC50wV7pyBuT+D0CODUuZ5s
         xUvLD5f8rXTUaxVnBeqAVfPJif/9PSW0lPqfQa2OdLuatH3f3un1XHWlm+4jUJ0TbTcR
         1/YdhnJdfo4gcUhVoLTycO6rSw4WywGrQZlp+fiMdcVxhGH/vj5XIwqEFNa3tUNQofU+
         4Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iMxvlfVJes5FFeE0X6U3U1fK4vtuWp5d/VgULw7RcSI=;
        b=CcX6nad96xdWMtRDHqIEbFaeqiovHWdtCQ5ISAyUnpzj/a4lb+Tn/3DEknZdAih2vE
         f/ACE7AruHrI6krilA82m2IlSy9M47U3Gkr93UJrJXuelyvQcDpm+PlFvjHJ/aknO6v3
         430R/+Q5zb1+3RFlyVMPbSpP1axXwgw/PvESqtAflAZ82kkSQFIzbejd7PvfHADJwdNo
         TWHT2AHAOTGHzROWBvErj/27MaD5JnR/1WUFmL9yFGA34bKPjLhD0mKQkIGGgU95rbc0
         +VTpfzZYlG9+1+AuM6+CsP4e1RLc5g482MSUTzMj1lVmnKDOYO1DwwWKAuQFx8leT8Xl
         +F6A==
X-Gm-Message-State: AOAM532aTop89/foE5QnaON/Q4Ni66ZHFmJBbhMkGG/2MsnOU0H+i6Lv
        d4DOyD3ucj+H3+haabkyTqz8YnFGDhZQvaRYKri0QAea
X-Google-Smtp-Source: ABdhPJyIJlQyveFJRBWlobIQhAfUPY8tWa+y7bymrNTqrBfWTL8U+WaPVLz/jKeC05Vq1BgoVncsMltqB/K11pbn5uo=
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr697068ejt.305.1637606810259;
 Mon, 22 Nov 2021 10:46:50 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 22 Nov 2021 13:46:38 -0500
Message-ID: <CAN-5tyEXpxcfWSjOrWsCRiyYvZmh6pk7gZKBz=XApr0d4z1fGQ@mail.gmail.com>
Subject: fs_locations question
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce/Chuck/Trond,

Question for you: currently, the linux server replies back with
FS_LOCATIONS as a supported attribute. Yet if the client were to ask
it for FS_LOCATIONS (on a root of the filesystem), the server's reply
is a 0 value. I'm not finding anything in the spec that talks about
what the reply should (or shouldn't) be. Is it the client's
responsibility to interpret the 0 value reply as no other locations
are available. Or is this an invalid reply and there should be at
least the current IP present in the reply?

It's unclear to me what and how this situation should be solved: on
the server side or client side?

Thank you for your help.
