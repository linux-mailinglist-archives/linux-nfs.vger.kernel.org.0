Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE220DB85
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbgF2UHS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 16:07:18 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:50287 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729373AbgF2UHQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 16:07:16 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jpuTZ-0005od-7m; Mon, 29 Jun 2020 09:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yfqcHGsgbVNwSVOE96ED7QFGFR+4k0cNIE9PBNLyS44=; b=LxF6M5iVFH1rPgMOE9Q3+jQc0F
        CF90LX7PiRTAQxQzoLHnV9pLB5wzyMImX4xhmiCLVVLgW1wUIdHR0y+X+j0SnPrb3qOgHetwQR9oG
        gWOtebLjfQMvrdnH7BtUYjXHgId8UAlM+xaGZD5MHNrA+XE8e2Ppemk9sV++0ywCHt+w8BjqL5Xvo
        l1GgaaKySiBakwTzdhWKNmIqFh1foDqP8Bq2yUJIfz9hxXuhfuA0x7bOoeA0UPRI3eQJ8LANU0ymo
        ebytaRzs05hk4qFKnq5ZadITCmHqMJx8X8YIAT2sfknBLK+jcu5YcHFC3aqfYkT917vwSC6sHEmQl
        zynU2XiQ==;
Received: from [174.119.114.224] (port=60618 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jpuTY-0005gy-4b; Mon, 29 Jun 2020 10:09:36 -0400
Subject: Re: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in
 Debian Buster
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
 <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
 <20200626194622.GB11850@fieldses.org>
 <3eb80b1f-e4d3-e87c-aacd-34dc28637948@nazar.ca>
 <20200626210243.GD11850@fieldses.org>
 <bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
 <6cf63c80f285495d8328c5c8b55fc9d6@tu-berlin.de>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <41614030-a616-1ad0-280c-7e24342cd455@nazar.ca>
Date:   Mon, 29 Jun 2020 10:09:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <6cf63c80f285495d8328c5c8b55fc9d6@tu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVvbDy/9MK5kFq
 xPuLb6onRUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKThTT
 uTzzE6IXwvY6nHo4sMR7z3Qmxf9LL3YwTn7mqFDKhD3eopicjALgkOhTtfsl+Ko2AgdDl0X122/y
 ecgK81hjtKXqX2R4K0XNQpmBqHFTQjBWL8RNTyPJzsds9V/6lEwmr6TNDmoNGsncSY9bd15pRS7f
 7mZVK7fXToVZ6vCgu4aV6E2UnWQ5LtEEB+XvLRyeP3kMF/HM2qi7bXBmBn+u1WaiZswnh7amfkLT
 IEwd6LkGFt94dBx3TpAokA4UmbCGVypsM2xk+Fb6Uy9BG+eG09xLM7yGwGwdmctNXf+yF45HU3lW
 dqhlsf8B0aV+vLwhC45y7F6Q5PEoXTb+KPAIoaacdoUTZPqsW5IYvohDIxfs2qKc0fhF4YMd0lwH
 wOXyY7DGIntSiB4r6Kj1fsgmrNzcio0vvTNoY5tUR/a/1p3btshdqNdejy9cf5FpO1goS3MkISSy
 dS6EA7KSoHbm+ifPs2yIXVaS7j1CpD4sbMC/K6klzbRMjzrXH/SDfWiH1Wgh6RAenBR+licROGZg
 nHuN3T3lnVlGD4niHpIoevbTmP6zX4CU1xL6keyrGY0LnHT8yy5Ar3sXfVdEv8RHfqKKhnXuHBKx
 2WmGgCd6OGA/nCOmvrY4iQcbIGanrffQsJMjVuaCfq+S2F3DJOIRFZ4oobg8BBg3Jq+ntzj0rh/2
 2eyHcgpFD92kILePdl2bSnc9GinQymBttOmXG2/AMTL+ZoFzBGSZfKA1OWq88wHL8rsvWDB30Q9t
 MrtTasA/9xGgj7taJxWtHZ97uYqgmGT5RbB5IWt8fZ6ctVYFYnNGFdRN3CtPPBjSHkIxZatgw7Jg
 KTqMJNGdaglvWusdDN2jqhFWg+7z30fj3VpdeToUvy4JCT53crzj1o5/muiPCtB/5ydmLUuJyvfZ
 LuDOE4wUcLzs7u9jpBeoYE7DC0Hh3V60YI4Fdc71eibaCdbFBCUcNiB34tnDdEu8PUIxL7hrJSk6
 0SF3F6RYOYr2
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-06-29 01:39, Kraus, Sebastian wrote:
> Hi Doug,
> thanks very much for your patch and efforts.
> I manually backported the patch to nfs-utils 1.3.4-2.5 source in Debian Buster.
> I am now testing the modified build on one of my NFSv4 file servers. Looks promising.
>
> One additional question: Which nfs-utils branch are your working on - steved/nfs-utils.git ?

Yes, I'm working against upstream. I did check briefly that the code 
hadn't changed too much since 1.3.4 in that area.

I've found one other place that has insufficient locking but the race to 
hit it is fairly small. It's in the Kerberos machine principal cache 
when it refreshes the machine credentials. I have a patch for that, but 
it's pretty invasive due to some other changes I'm currently working on. 
Let me know if you hit it, and I can work on a simple version to backport.

Doug

