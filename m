Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236AB197F3E
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2020 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgC3PG7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Mar 2020 11:06:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26121 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbgC3PG6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Mar 2020 11:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585580818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tA2WHoEVoe7p3oV/qrDL+LqEOX3KEVDTlCYcEUIFJ8g=;
        b=C6OyfAgN8wIOd52zj4HVfIVRhtXLSxVn6yuEKVcikENdQyjqMEvorXgaTzwH23cjb/PcRF
        I5LKZeBTlM2Ue2aIqdujVBQEzHOGf7h1E47gUV+zpLagVCo5/s51dZ3JJCz1Lgg292AoEB
        zZHVVb5HYpq8btPy2e2yDZw0DFYl8SA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-E8bx9aWEMraTjVkd_UUZUw-1; Mon, 30 Mar 2020 11:06:56 -0400
X-MC-Unique: E8bx9aWEMraTjVkd_UUZUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3EB10CE780;
        Mon, 30 Mar 2020 15:06:55 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-250.phx2.redhat.com [10.3.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB90260C85;
        Mon, 30 Mar 2020 15:06:54 +0000 (UTC)
Subject: Re: libnfsidmap: SASL bind suppoprt in umich_ldap
To:     Srikrishan Malik <srikrishanmalik@gmail.com>,
        linux-nfs@vger.kernel.org
References: <20200330123501.GA50689@C02W82TBHV2R>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <b9c6f7bd-ed86-4951-98cc-0e2938d0a2c3@RedHat.com>
Date:   Mon, 30 Mar 2020 11:06:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200330123501.GA50689@C02W82TBHV2R>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 3/30/20 8:42 AM, Srikrishan Malik wrote:
> Hi,
> 
> This is regarding the umich_ldap plugin in libnfsidmap.
> This plugin uses only simple bind, are there any
> plans/ongoing efforts to support SASL binds.
No... Not that I'm aware of... Patches welcomed!  ;-) 

steved.

