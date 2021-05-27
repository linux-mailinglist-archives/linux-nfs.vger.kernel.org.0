Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759C339344E
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 18:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhE0QvW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 12:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbhE0QvW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 12:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622134188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzqDS9vthqMOOgivvdyqpJvIHIiwMK8Y2JKSfmxIgtI=;
        b=Jcas8GRsRh+/UTBsJ8ypqgDZT3K3fszgJx/RjurnEPL9XgbzrVJu7reI+jigVYfI+OJAaP
        MzMm1xahYz3kDdvILN6V+8pp2Lx6gp8/MZPB7idQkxW9nDNR7PpIayLXwbmMpgq0BXpgdW
        Ir3zVU+BUWosVPIjWJOGnwgEfM9DPAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-ZbuvtrzlO524mvJ1hMy8sQ-1; Thu, 27 May 2021 12:49:47 -0400
X-MC-Unique: ZbuvtrzlO524mvJ1hMy8sQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DCEC107ACCD
        for <linux-nfs@vger.kernel.org>; Thu, 27 May 2021 16:49:46 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-114-18.rdu2.redhat.com [10.10.114.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A08050F70;
        Thu, 27 May 2021 16:49:46 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 4AA391A003D; Thu, 27 May 2021 12:49:45 -0400 (EDT)
Date:   Thu, 27 May 2021 12:49:45 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils RFC PATCH 2/2] gssd: add timeout for upcall threads
Message-ID: <YK/NqXc7OR0qQCPd@aion.usersys.redhat.com>
References: <20210525180033.200404-1-smayhew@redhat.com>
 <20210525180033.200404-3-smayhew@redhat.com>
 <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
 <64b6f93a-e81c-fd8a-8db5-44e69004294d@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b6f93a-e81c-fd8a-8db5-44e69004294d@RedHat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 27 May 2021, Steve Dickson wrote:

> Hey!
> 
> Off-list... 
> 
> On 5/26/21 1:08 PM, Steve Dickson wrote:
> >> +		free(tinfo);
> >> +		return ret;
> >> +	}
> >> +	printerr(1, "created thread id 0x%lx\n", th);
> > This will be removed... 
> It turns out this tid is useful since the 
> tid is used in the do_downcall() db statement. 

I already got rid of it!

> 
> In general I've try to always used the function name
> in the db statement so it is know where it is.
> So maybe something like this:
> 
> pthread_t tid = pthread_self();
> 
> printerr(2, "start_upcall_thread(0x%lx): created thread id 0x%lx\n", tid, th);
> 
> steved.
> 
> P.S. After your final version, I'm going to follow up with a debug clean up
> patch... So I can take care of it there... if you like.

> 

