Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1313FA2B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 21:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbgAPUHG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 15:07:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729075AbgAPUHG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 15:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579205225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=870o2IH+Ue8GAMWvbSe6HFk8kAi6bYBenboeyuRM/ng=;
        b=Jyaj/pN8vgc4y9iWNly/YgnbZ6ZEYC4ifLd0AJvQnb4OieoHUzXIIzne5eGniUkqbQj63X
        QuMX+4tW09RbeCqA8w51BNsgjiWiBf1S2ZGZI0JEj+GQYzt74p+fvl4axitwAVRMyIA+Cx
        iI9TjJWGys0NQdLUP915wvRws2FM4EQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-qTqNWcsQNiC_omWNyqYW9Q-1; Thu, 16 Jan 2020 15:07:02 -0500
X-MC-Unique: qTqNWcsQNiC_omWNyqYW9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 490E41015FA2;
        Thu, 16 Jan 2020 20:07:01 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-35.phx2.redhat.com [10.3.117.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB4B460C87;
        Thu, 16 Jan 2020 20:07:00 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 5/7] rpcgen: rpc_cout: fix potential
 -Wformat-nonliteral warning
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
 <20200103215039.27471-6-giulio.benetti@benettiengineering.com>
 <dd75fa26-a07a-49fb-ed22-1e60da31c8da@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <a9f351c6-22e5-35ef-7119-d261ef8d0159@RedHat.com>
Date:   Thu, 16 Jan 2020 15:07:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <dd75fa26-a07a-49fb-ed22-1e60da31c8da@benettiengineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/15/20 11:29 AM, Giulio Benetti wrote:
> Hi Steve,
> 
> you've missed this patch while applying the series. Can you please commit it?
It is in...

commit 6f4568f1f7395f967cc03995dcfb79a1ac5c11cd
Author: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date:   Mon Jan 6 14:23:04 2020 -0500

    rpcgen: rpc_hout: fix potential -Wformat-security warning
    
    f_print()'s argument "separator" is not known because it's passed as an
    argument and with -Wformat-security will cause a useless warning. Let's
    ignore by adding "#pragma GCC diagnostic ignored/warning" before and
    after f_print().
    
    Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
    Signed-off-by: Steve Dickson <steved@redhat.com>

what am I missing?

steved.

