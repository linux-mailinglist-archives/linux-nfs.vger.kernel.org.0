Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B278B2A3F8
	for <lists+linux-nfs@lfdr.de>; Sat, 25 May 2019 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEYLJR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 May 2019 07:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfEYLJR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 25 May 2019 07:09:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3503B37EEA;
        Sat, 25 May 2019 11:09:17 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A646060FAD;
        Sat, 25 May 2019 11:09:16 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J . Bruce Fields" <bfields@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] NLM fl_pid fixup
Date:   Sat, 25 May 2019 07:09:17 -0400
Message-ID: <114775E1-D195-4DE1-8920-CC750DBB44C2@redhat.com>
In-Reply-To: <20190524164759.GA23881@fieldses.org>
References: <cover.1558622651.git.bcodding@redhat.com>
 <20190524164759.GA23881@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 25 May 2019 11:09:17 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 24 May 2019, at 12:47, J. Bruce Fields wrote:

> On Thu, May 23, 2019 at 10:45:43AM -0400, Benjamin Coddington wrote:
>> This series aims to correct the fl_pid value for locks held by the 
>> NLM
>> server, or lockd.  It applies onto the revert of the previous attempt 
>> to fix
>> this problem sent ealier this week: '[PATCH] Revert "lockd: Show pid 
>> of
>> lockd for remote locks"'.
>>
>> The problem with the earlier attempt was that we discarded the svid, 
>> and so
>> we couldn't distinguish remote lockowners on each host.  It is 
>> necessary to
>> turn the svid and host into a distinct owner.
>
> So, to make sure I understand, we've got multiple ways to identify a
> lock owner:
>
> 	- the svid, the pid of the client process: this gets returned to
> 	  the client in grant callbacks and (possibly to a different
> 	  client) in testd results.
> 	- the pid of the server's lockd process: this is what other
> 	  processes on the server see as the owner of locks held by nfs
> 	  clients.
> 	- the nlm_lockowner: a (nlm_host, svid) pair, used to actually
> 	  decide when locks conflict.

That's it.

> Makes sense to me.
>
> I'll send your earlier revert to stable, then add this on top for the
> 5.3 merge window.  Sound OK?

Sounds great, thank you!

Ben
