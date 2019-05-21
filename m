Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425A425956
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfEUUp3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 16:45:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfEUUp3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 16:45:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E1F030833C2;
        Tue, 21 May 2019 20:45:28 +0000 (UTC)
Received: from [169.254.32.230] (ovpn-117-179.phx2.redhat.com [10.3.117.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DABDD6013B;
        Tue, 21 May 2019 20:45:27 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     "Xuewei Zhang" <xueweiz@google.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Revert "lockd: Show pid of lockd for remote locks"
Date:   Tue, 21 May 2019 16:45:26 -0400
Message-ID: <A6640E39-5B5D-4CF3-8131-62F8106ED2E0@redhat.com>
In-Reply-To: <20190521155821.GD9499@fieldses.org>
References: <952928a350da64fd8de3e1a79deb8cc23552972f.1558362681.git.bcodding@redhat.com>
 <20190521155821.GD9499@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 21 May 2019 20:45:29 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 May 2019, at 11:58, J . Bruce Fields wrote:

> On Mon, May 20, 2019 at 10:33:07AM -0400, Benjamin Coddington wrote:
>> This reverts most of commit b8eee0e90f97 ("lockd: Show pid of lockd for
>> remote locks"), which caused remote locks to not be differentiated between
>> remote processes for NLM.
>
> To make sure I understand: I assume a client resolves conflicts among
> its own processes before involving the server, so the server only needs
> to resolve conflicts among nlm_hosts.  Is that right?  So the only
> practical affect is the missing grant callbacks that Xuewei noticed?

For the linux client, I think that is correct.

> Or is my assumption not true in general?  Or is it true only for some
> client implementations?

I don't know the answer here.  I imagine a client could leave off checking
for local lock conflicts.

I have a set of patches that stuff nlm_lockowner into fl_owner on the
server.  That allows us to set fl_pid of lockd and not lose the svid.  I am
just testing them thoroughly at this point, and I'll probably get them
posted tomorrow.

Ben
