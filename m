Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9922375
	for <lists+linux-nfs@lfdr.de>; Sat, 18 May 2019 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfERMJn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 May 2019 08:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbfERMJn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 18 May 2019 08:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 701623082E4D;
        Sat, 18 May 2019 12:09:43 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98B252D1C6;
        Sat, 18 May 2019 12:09:41 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Xuewei Zhang" <xueweiz@google.com>
Cc:     bfields@fieldses.org, "Grigor Avagyan" <grigora@google.com>,
        "Trevor Bourget" <bourget@google.com>,
        "Nauman Rafique" <nauman@google.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] lockd: Show pid of lockd for remote locks
Date:   Sat, 18 May 2019 08:09:42 -0400
Message-ID: <3A924C3F-A161-4EE2-A74E-2EE1B6D2CA14@redhat.com>
In-Reply-To: <CAPtwhKrJw54DmfVdP4ADd3w5QPv0cRP+kr1Atn58QOFL5xBGbA@mail.gmail.com>
References: <CAPtwhKrJw54DmfVdP4ADd3w5QPv0cRP+kr1Atn58QOFL5xBGbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 18 May 2019 12:09:43 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 17 May 2019, at 17:45, Xuewei Zhang wrote:
> Seems this patch introduced a bug in how lock protocol handles
> GRANTED_MSG in nfs.

Yes, you're right: it's broken, and broken badly because we find conflicting
locks based on lockd's fl_pid and lockd's fl_owner, which is current->files.
That means that clients are not differentiated, and that means that v3 locks
are broken.

I'd really like to see the fl_pid value make sense on the server when we
show it to userspace, so I think that we should stuff the svid in fl_owner.

Clearly I need to be more careful making changes here, so I am going to take
my time fixing this, and I won't get to it until Monday. A revert would get
us back to safe behavior.

Ben
