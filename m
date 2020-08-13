Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC7243994
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Aug 2020 14:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHMMEY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Aug 2020 08:04:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47022 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbgHMMED (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Aug 2020 08:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597320241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EmPOEUUffds4EZ6g/2MO/BJL9x/xE+VqU9IbU++EvOU=;
        b=C/AZ6AHPKM4NFHM3m/JBb75ZyLqSVH07485ZJsgOq70hvjJK3BQZzk2zEEjnS+4TQjmacP
        fAcro2OJaKMO7eq8wrqQuRTyUHeWlQTzguFw1VIcHZShY43vMx0mFYs0umKgTOL0Rd1Tx9
        BKl/7sKHCMg6xnuya486hSmc7MGqomA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-jf7aivWeOt2YFsTmNswYfg-1; Thu, 13 Aug 2020 07:45:34 -0400
X-MC-Unique: jf7aivWeOt2YFsTmNswYfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF2541008542;
        Thu, 13 Aug 2020 11:45:33 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-130.rdu2.redhat.com [10.10.64.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FB5B5D9E8;
        Thu, 13 Aug 2020 11:45:33 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "NFS Traumatized Linux User" <nfstrauma@busy-byte.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: CentOS 8 + Kerberized NFS homes / AutoFS -> can't get this to run
 properly, many actions heavily delayed, freq. mouse/kbd freezes -> NFS issue?
Date:   Thu, 13 Aug 2020 07:45:32 -0400
Message-ID: <534BA86A-9A94-4B0A-98ED-11E171BE63A7@redhat.com>
In-Reply-To: <f68660cb18742f7dfdd8a796a610329d@webmail.busy-byte.org>
References: <f68660cb18742f7dfdd8a796a610329d@webmail.busy-byte.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12 Aug 2020, at 16:05, NFS Traumatized Linux User wrote:

> Hi there,
..
> Any pointers / help would be greatly appreciated.

Delays in the UI on the order of several minutes that are suspected to be
NFS related should be visible in a wirecapture.  Have you tried using
vanilla krb5 and if the delays are still there, what does a wirecapture of
the NFS traffic look like?  Are there long delays between each RPC call and
reply?  That's the place I would start.

I can say that this problem sounds a bit like a name resolution problem
somewhere.  Long delays that produce no errors at random times often turn
out to be systems repeatedly trying to use a name server that doesn't reply.
Perhaps either the client or server's name services are trying to look up an
identifier and there's a DNS server record that isn't replying - but that's
a wild guess.

Ben

