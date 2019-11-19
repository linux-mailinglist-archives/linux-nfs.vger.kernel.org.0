Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473BE102DD0
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2019 21:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKSUyx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Nov 2019 15:54:53 -0500
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:47683 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbfKSUyx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Nov 2019 15:54:53 -0500
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <nazard@nazar.ca>)
        id 1iXAWP-0005Tm-Ll; Tue, 19 Nov 2019 14:54:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NSXtyQ+cxZiov1h/msqQAYyX8kGKDW7jo/19LBhE6fA=; b=j4rLnlBa0wiSwoFfwvvckMtMgX
        GA6wwR3YFcGh01gw7RZq33+2jsxyQCxSYVK4GxnOPRKdQdKPeLxYyp1MMlxVBIpHYUKj7JJWMevMS
        y39bAejQUBomIobW+ozfnAYgcfNZkAxspfDRYUF8BW+FD14OyjiH5H6fXCi5xVyT8aqf7mt8Tk/Ly
        y0liuuWV55P9V/zlqDumyul61HoGEfKLjoy7jt0Q0kZmmFZWQAj+tHt/QsJ5Gj3p7CdmoZCB8O3eO
        pBOO3FpgkfdtiED7T91POTcYmVNTsAjKgovJxQE+Fz9UlxvlsATaJMFFC6zlNq0rPrXwPdSGQ5jfb
        k+Ov4/Nw==;
Received: from [24.114.55.59] (port=47731 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1iXAWP-0002Wh-B6; Tue, 19 Nov 2019 15:54:49 -0500
Subject: Re: ANNOUNCE: nfs-utils-2.4.2 released.
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <04f375d6-e50a-0b5e-7095-dbc3907bfe23@nazar.ca>
 <fd6a75d4-9b52-9c8f-9ad5-d01340fdb89e@RedHat.com>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <455b1ca6-85b4-c8a2-d66d-389115c5b94d@nazar.ca>
Date:   Tue, 19 Nov 2019 15:54:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <fd6a75d4-9b52-9c8f-9ad5-d01340fdb89e@RedHat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AuthUser: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: relay
Authentication-Results: arandomserver.com; auth=pass (login) smtp.auth=relay@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0fIjBzH0XxYvWQgWH/ix0mSpSDasLI4SayDByyq9LIhVLYckMR2npU0w
 on5gD1y0FETNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTibW
 aG5S00Ke4iKnmCsTdmJlcUeN/JW8E9PaHbmUYGTMTX+DNB8zzxX/4FjqtJmb5OTijZousobAGphh
 44GwGrcBzS5fPHINUJxVzZg1ZLp9gmsYntIZvASFzmmwEK8xkpmNQB3hWTYq/vzakcc65ZBQkiNC
 3M7Pj/MY9gGLjh/nwB5YOcnLTEWr5QFxf29u2b0ZFs7AIGlqJcSMQo9hh7aOmrbMWhZFkvyjvYIF
 be8tdb9BwqvSI91oKEKHszPrHLIoTCzQ7XvYo5qydvprZHcSCR22vShmebXILNDFNYkR6LCtYz5o
 yWoRpE2M2XALSMDT9ZG0CmXc0v4tKHsUSjuO8OL3MKmWpyx7GTPK+LOWY5R6BpcvGp3jcY/qUcse
 gxHyS9oTCOMgg0kq/x8Q8jegKor5vGLGjUegAaOB9ePyJLFZV2VsWrEXxYzPJvIeyCEnVSsgPP/M
 gqSGMx92qX+/Ib/3gD1xdv4OjYexFN7ik4oYRgdX/aeSLw4ZD+8uTG/yF5Sslr7rjwGaoPhs3lTQ
 GySeCtqT3bGichkfpVFEkDzLsegeIf5jR5PNTlF6ReCprMAKLZ9Vvl2XZc6+7+zUzX99k5ROK7DU
 2cuVvM4pN2jrzuqNLgr3QpfT+A5/9mbzroJXjH7wQNY/kO3yis9UoFIvD3sIcP1fhJPM6B/88jKA
 awtiqD4pHSIImIBBBlgZ3grvRyEafQhYvAD8GLUxcfxmM3wdGChc6hHRfRowObH2LW6BIAQW76wb
 eBOhgzcKVNeVJ9BXyu9+ceCqThQaHAwskslMOiSjwnYcoQfxx57gE89ByJNnvoZD/j4xXaiZ9OGv
 SyF6jGxmwlE+D33NBz6C+Mu+hGpwr7PBqmKnubcolFl/rX+2ReQklqJDAdqlKemfur/8qYsUn20e
 BeH3y8h6dUrDs43Vm7LtiRHY
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2019-11-17 14:40, Steve Dickson wrote:
>> Also attached are a few printf formating fixes for 32 bit.
> My apologies... I did miss this patch in the last release, but the
> patch is now committed...
>
> I blame the American Halloween... the day the patch was posted! :-)
> Those darn spooks and goblins of getting in the way!! 8-)

I'm sure they're to blame... they always are getting into things... ;-)

My fault for not sending it separately, but there was another patch 
attached to the last email to fix some printf formatting strings for 32 
bit clients. Let me know if you'd prefer if I send it as a separate email.

Doug

