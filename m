Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B017C109987
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2019 08:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfKZHWt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Nov 2019 02:22:49 -0500
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:33323 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfKZHWt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Nov 2019 02:22:49 -0500
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <nazard@nazar.ca>)
        id 1iZVBL-0003SP-Cw; Tue, 26 Nov 2019 01:22:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:In-Reply-To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pc2ZAQDmiHw8vRZvn1b8CxC3zMoQAd/89NWd6ohh4FY=; b=MRUeFErC/+f2i5OFFaq+COF301
        A9QRJNowakWGttcBAIiZ7yfLMF097EwkkNt21yDieC0Ne6nllL6tewyFJcFzxgZD5wZ+WEm1bNsza
        vUbXgvwONEjieqZiCobBDBCGAm2kmTyjljbqudEckHNiVJGeqIuOLt913Rg0HHu6UqYqFYE5K2ZGT
        jm9bEZ5WGk5flcB6C+C07Ce+luG1p+Ep0M3Q8AAfNMP9S56dWedqAlt2cLuibE61EKav+6xGRlqBH
        wZJFnylz/qJqNYRdtdL3ak0qB2D+1PPtBKaHbN1aK6wV668+gwtDOgWL243IxqoUWhW4M4uQbB1hs
        7Iu903LQ==;
Received: from [72.136.97.100] (port=43800 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1iZVBK-0007xZ-Qj; Tue, 26 Nov 2019 02:22:42 -0500
In-Reply-To: <20191011170709.GE19318@fieldses.org>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Thomas Deutschmann <whissi@gentoo.org>,
        Steve Dickson <steved@redhat.com>
From:   Doug Nazar <nazard@nazar.ca>
Subject: Re: nfs-utils: v3 mounts broken due to statx() returning EINVAL
Message-ID: <dd522611-f8eb-bb94-9ec6-09a6725e8cca@nazar.ca>
Date:   Tue, 26 Nov 2019 02:22:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AuthUser: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: relay
Authentication-Results: arandomserver.com; auth=pass (login) smtp.auth=relay@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00992890140263)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0VyY7+E5Em8uC8nykI/JrD6pSDasLI4SayDByyq9LIhVET2ExkyOORtv
 V770RX9C+0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K7jpJ6fO8V8ckN3TGhp82q15v
 4DpS5qhb5OR35I/Qhd61lz/Mprl7l96QEPFePvlc5BSmiObqWWqQlXWjcYmyYea/B7VvovszkhKe
 Buv5yk7NycgmZX8Q6sbeO2hINsEtHl73ve96GBFEwl13XHj3xAahiODpDPgVWIh7rs5Pr10Zksgf
 IGC5xYKD5STQv5mxYlxqULwMDXAZAAsky53+ClfqPuEYdWkbwCU2ljQk1HvNBz6C+Mu+hGpwr7PB
 qmKn7bgNQRm1OeEwNfs/X7KNpoOOmuxfi2h11xUMqwLB3tTsBG47lHQZCNJXRN5UEWm/GksMJMxe
 JLPEOTZkA95NmGNo6i9HUMb3yP3hxWEhfOmxjnApF2+xSnaM3Oz7g5jQv+KD7QreUnMI3QVIL+Ru
 1NzKetqAKPuAEDRHKXdWyG8ifL76GD10kuo3nOZaoX+gATrOHvhIftIZ0OCqnL3dhdHKOU+vlscC
 ylkFhSSjURNOB0fQQI8VICRbS6zGNgmkvcGASdA+L9ESXfzmPAT59hNfkPQ0eGG0BkZ/0ghVUjHJ
 wcJ3z+7xFrhXUzZERlSgGplHcpVCCoX989hgB8R+yE44UEQYgR9yzpxn/WkdPHXytk+Tjz72sXtp
 ME7wZBG/rJzgJ1F2AiKog729Bd//q2bf2jeYVce2zy47eZfFEx7DbL/8Lyd37SwvszjSXIcT5CL/
 kimDnHzg9QdLPVigKTRqq9XJ3A7TbtUilHMjAbMQ9r701nWrAsLwohWm7wYLseu46o3+/BvePmej
 h8aFcWgPKLRzciyLGrHqHQBVHgQccBIk1Sag4dKiqCrF8eZZ3gAFgf5pxcvjqhYUkJ+PVcagBWhr
 PqYGcDoUB+MVMogTqfDNG/eSEDCU3zUmlBVgZvOugleMfvBA1j+Q7fKKz3fccSHpoEA6x1E6NCAy
 03IIEaw2FATNOSyR0hlRJ2bU83KrEXc+Z1DahbUFzBX4rvXS1+qgaVt1ORMtpYIBctpo5lIZ42Pp
 IMd67+j9MC/iEbKoMM0R+bccIbn7fCdCag==
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 11, 2019 at 17:07:09PM +0000, Bruce Fields wrote:
 >On Tue, Oct 08, 2019 at 10:23:56PM +0200, Thomas Deutschmann wrote:
 >> Hi,
 >>
 >> we have some user reporting that NFS v3 mounts are broken
 >> when using glibc-2.29 and linux-4.9.x (4.9.128) because
 >> statx() with mask=STATX_BASIC_STATS returns EINVAL.
 >>
 >> Looks like this isn't happening with <nfs-utils-2.4.1 or
 >> newer kernels.
 >>
 >> The following workaround was confirmed to be working:
 >>
 >> --- a/support/misc/xstat.c    2019-06-24 21:31:55.260371592 +0200
 >> +++ b/support/misc/xstat.c    2019-06-24 21:32:29.098777436 +0200
 >> @@ -47,6 +47,8 @@
 >>              statx_copy(statbuf, &stxbuf);
 >>              return 0;
 >>          }
 >> +        if (errno == EINVAL)
 >> +            errno = ENOSYS;
 >>          if (errno == ENOSYS)
 >>              statx_supported = 0;
 >>      } else
 >>
 >>
 >> Bug: https://bugs.gentoo.org/688644
 >>
 >> At the moment I have no clue whether this is kernel/glibc or
 >> nfs-utils related; if the patch is safe to apply...
 >
 >Well, sounds like nfs-utils started using statx in 2.4.1.  And just the
 >fact that varying the kernel version makes it sound like there was a
 >kernel bug causing an EINVAL return in this case, and that bug got
 >fixed.
 >
 >One way to confirm might be running mount under strace and looking for
 >that EINVAL return.

Just to provide an update on this issue, it was tracked down to glibc's 
statx emulation not supporting AT_STATX_DONT_SYNC and returning EINVAL.

So on a kernel without statx support, but a new glibc with statx 
support, nfs-utils will always fail to stat any paths.

Either this or a similar fix is required to support older kernels.

Doug

