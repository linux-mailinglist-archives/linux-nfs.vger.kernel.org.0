Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B7723C130
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 23:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgHDVHy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 17:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHDVHy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Aug 2020 17:07:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5CC06174A
        for <linux-nfs@vger.kernel.org>; Tue,  4 Aug 2020 14:07:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id lx9so3078863pjb.2
        for <linux-nfs@vger.kernel.org>; Tue, 04 Aug 2020 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=7UjTDqgcW6Umba1VCqOBPrOSd4PSKS8Z3PzMGw8HcX0=;
        b=ZvoVONWRm7JUEAOlLcALDs5wEyUpjRBjnyCJaYQHqgKGQbcgFMT9UAg7dkHDIC3o7R
         r1BmxD1kTQdYuSjkR7ncupJouR5dOXDM6ar+DhhLlmCe4ZUm1SgsAjRD4FiLBSamU7xw
         SXBNAYv0WDCKRD0sF6ZnMJynfFzHNXgAx1dnCGhpyFZpOg6LASeoBKpo2H71riuLWvIq
         pIOaLdbskj6SWf1b90jZd8OGBuW6fiWtdz8BvpWIJfzmXfk37Wg5/BpuPguKLZ7EcSf1
         t5lE+nEsDb4QKejtJBM1ms3qi8+Yz/yI+tMA+IW/q0wiZt8XYfMt4SrRWUVNf/bNlj8/
         cv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=7UjTDqgcW6Umba1VCqOBPrOSd4PSKS8Z3PzMGw8HcX0=;
        b=tavMiX38M9kCSWY1s1SmQdbPHAfxZDWOhudY71RzvErmfXKVFZOPKCK6PE5+pCm/vv
         XbbnTlNdu6WTd22jeLsw3tocHwuWld1ZOX+65QUZhwOGcTi+jADmKRutgF4HsH6c19ye
         HTp+29FYmG4K/BIMgGcne3cQHzFkNFtWI8bQsAmkibkuADG9rMA6cH1/zNRxZFE0C7qX
         lrBRb2VEdJ+prHbpwrCHUbDe4DZdvby84oYOxM8w7+ONNJ/Jd/zuGb0qiUGn38t0jhhV
         5ctOsA1NQvylVKoFk/yOPHop6Iuu5nLIe9XdIMYazQ7KjxMhsZo0m8acp5Zh8xxMJB+r
         vxOQ==
X-Gm-Message-State: AOAM53176Hej59Xe07vxlmq+Z5ZWKcnWfEwqLjetcve1kQyRFd3vyD+n
        /TWThHQHJDtUYsyO0yMOs9XT4g==
X-Google-Smtp-Source: ABdhPJwcUPFqR6uj/refIDJ1WaQED9WjF/w1yXEv0aAieW9UTx2SpsK89+131h3AZ9Z4hhPr51oBzQ==
X-Received: by 2002:a17:90a:f313:: with SMTP id ca19mr67824pjb.226.1596575273324;
        Tue, 04 Aug 2020 14:07:53 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r191sm25642040pfr.181.2020.08.04.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:07:53 -0700 (PDT)
Date:   Tue, 4 Aug 2020 14:07:44 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Fw: [Bug 208807] New: Problem with NFS kernel server code
Message-ID: <20200804140744.35ce4bdd@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Begin forwarded message:

Date: Tue, 04 Aug 2020 11:33:23 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 208807] New: Problem with NFS kernel server code


https://bugzilla.kernel.org/show_bug.cgi?id=208807

            Bug ID: 208807
           Summary: Problem with NFS kernel server code
           Product: Networking
           Version: 2.5
    Kernel Version: 5.8.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: nanook@eskimo.com
        Regression: No

Created attachment 290759
  --> https://bugzilla.kernel.org/attachment.cgi?id=290759&action=edit  
Output of dmesg while machine was dying

After about an hour and a half of operating on 5.8.0, one of our NFS servers
began to slow and basically ground to a halt.  Looks like a spinlock issue in
the NFS kernel server code.  I'll attach the output of dmesg while the machine
was dying in a file called "spinlock".  A shame because while it was running,
the performance of 5.8 was astounding.  Only the NFS servers seem to get ill,
the
client machines seem to run fine on 5.8 so far at least.

-- 
You are receiving this mail because:
You are the assignee for the bug.
