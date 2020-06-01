Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074DF1EA6BC
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgFAPRv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jun 2020 11:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgFAPRv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Jun 2020 11:17:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F8DC05BD43
        for <linux-nfs@vger.kernel.org>; Mon,  1 Jun 2020 08:17:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k19so7533044edv.9
        for <linux-nfs@vger.kernel.org>; Mon, 01 Jun 2020 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=zKxdkmhi3M1rHkXRBR18pioJZURS63Upm912Ufd4mhY=;
        b=fKQQxVi6RiLcJxETNOwyq5dX91D5GEtkbOXHAHObBMIHHpb18EYuHVg8Wc6ql92354
         GbywZeNYEmbKUhE+WU4cFt18/jWbutE3EPOESrWJNfyERzdvRStRMEWJ0XOaIT3+T7v8
         yqCNjaAzijITafpzPJ0RQ9iO9gIrkUA6atd/R5YsHgZbkMuakJcqmQIb4AIMtKblkcav
         URWVeCK5vNztJH2rWytqz7HJkq0Z2uXeTUpXRlWnSuF2FWzhLXnD7WZT9wEHIWzCQU+J
         u3CyNyFZnU5h/cTZaNFn/8MZm9V3U78W6HHv/3V7uE/749nHiDuiyUqTV8QB4thHTTzI
         q7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zKxdkmhi3M1rHkXRBR18pioJZURS63Upm912Ufd4mhY=;
        b=AbcaFQAsi0az23cMJY+Wq0T7oyKKuY9kyvRDmZeLm/6asLFok+D+qvMf6wzyIDiRgL
         FTnI4VBZYYBXSHhD78iyUjVyTP7Gmt23v5gHFerj1YI37wElJCFEdfJXKSIpKZqSCajA
         JqCJid7FLvwYbFsQHXic8631fkezhYO3RQn0DxDn72RqSBpefoDAO+ERe68nfRwCMwgY
         qMe9sNyL6ucpDz3He1o1Cd3HvV4et5xKCEmGU4YcIOdmsKcuIfqW46o0JiRb+9yR3Wl7
         6rwjc292w6ok1HKwlqzjUS6VTLZJ1QDGsSgLUvM0JZMrQDPXfTPMBvOQB9lQ3D52YfJg
         HFew==
X-Gm-Message-State: AOAM532XpkVL/mdVjcRiMqvVzaZiR8gHEMSnWscKE5q5Lk8Z0KSWXBfF
        FOmjD6CcU0JsA9RlOm/rrx+21jN7TO6cqrjuw7/yoREB
X-Google-Smtp-Source: ABdhPJxR6QpjkxTG3iENLtfcvP53r7xuM9XMxIat5G3Qhmij3EC+4NBGpLGgEg4+cVYCpgQ5j1UoR453HpiabGgp1V8=
X-Received: by 2002:aa7:d650:: with SMTP id v16mr21278605edr.267.1591024669338;
 Mon, 01 Jun 2020 08:17:49 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 1 Jun 2020 11:17:38 -0400
Message-ID: <CAN-5tyECUsBTUG2YScV8v6i7Y1164oRbOSvv4EUBDFRYKc+E3g@mail.gmail.com>
Subject: understanding why writes get priority over other operations
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

I'm trying to look for an explanation of if this is true and if so why
writes gets priority over other operations (like reads)?

I see in the code in write.c if FLUSH_HIGHPRI is set in flags then
we'll have an RPC marked with high priority. The problem is I don't
see anything setting FLUSH_HIGHPRI. I see that writes are written with
either FLUSH_STABLE or FLUSH_COND_STABLE (or no flags). Basically I
can't see how FLUSH_HIGHPRI is used.

If it's not used, then question: does the NFS layer ever priorities
writes over other operations? If NFS doesn't then prioritization must
be coming from the VM system I'm thinking.

Thank you.
