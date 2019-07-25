Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51E75493
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2019 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfGYQse (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jul 2019 12:48:34 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:33198 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfGYQse (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jul 2019 12:48:34 -0400
Received: by mail-qk1-f177.google.com with SMTP id r6so36970101qkc.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2019 09:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=ubL+VMPyjep1YsFCwqQoL4Bq8R4x0wFfg6zYmvlWL2o=;
        b=PilP1sZHlBiXkrc5HbILjc3ynkWRaqA8YK93DgsFGBHdS4notdye73p8+oR8jnB90c
         eTYRkDOtY7Agx0oKiIfH5e2/IJFoVePbH/vy3Co9dmtivp9On3Ge5I1g72eievAt6WF3
         pT2iT/erZ6ure6Z+HL2gl70+VkGHnYP2LOChr+WBnhLF083KBVopE+2q/4AkIPbCW3v3
         MkR+RoRKZIk3CBciMlbyFzlZLS/GchADjI+DBJctX5oqR7rrIb68DDeps36786B45QuK
         ec2O/3Io+q7cuZcHbKTCeStJCebF5KEY5BbKRkrzwF9ySFtv2gNCoee7nwX8Z43qkOCv
         KcHQ==
X-Gm-Message-State: APjAAAVwmTUlQpw/AtoTQUHZOTMuw1FUA/U1u9UOo3fYUPr+zHBvfj+f
        2XbcA6FxcOIDoNv7QT0OXfKAFxg5kPQ=
X-Google-Smtp-Source: APXvYqxS1SFZSFaGv37Aj4MsQgV4fotkyagyplkWJktc0jCQfTIp/fwsheBvRtWRvuxGvKNKljM58A==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr60430063qkk.82.1564073313549;
        Thu, 25 Jul 2019 09:48:33 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id g2sm22385399qkf.32.2019.07.25.09.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:48:32 -0700 (PDT)
Message-ID: <22770aa2024c1dab1b7eaded1eed9957963413fb.camel@redhat.com>
Subject: RFC: Fixing net/sunrpc/cache.c: cache_listeners_exist() function
 for rogue process reading a 'channel' file
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     NeilBrown <neilb@suse.com>, Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 25 Jul 2019 12:48:31 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Neil, Bruce, and others,

I want to see if we can improve cache_listeners_exist() to not be
fooled at all by a random process reading a 'channel' file.  Prior
attempts have been made and Neil your most recent commit mitigated the
effects however doesn't really solve it completely:
9d69338c8c5f "sunrpc/cache: handle missing listeners better"

Here are a couple approaches, based on my understanding of the
interface and what any legitimate "user of the channel files" (aka
daemons or userspace programs, most if not all live in nfs-utils) do in
practice:
1) rather than tracking opens for read, track opens for write on the
channel file (i.e. the 'readers' member in cache_detail)
2) in addition to or in place of #1, track calls to cache_poll()

Basically the above would create a 'cache_daemon_exists()' function in
place of the existing 'cache_listeners_exist()' and then add some
further logic to it.  Do you think that is a valid approach or do you
see problems with it?

Because this keeps coming up in one shape or form and is hard to
troubleshoot when it occurs, I think we should fix this once and for
all so I'm looking for feedback on approaches.  I thought of going down
the road of a more elaborate daemon / kernel registration but that
would require carefully making sure we have backward compatibility when
variants of nfs-utils and kernel are installed.  I think it may be
worth looking at less invasive approaches first such as the above, but
am open to feedback.

Thanks.

