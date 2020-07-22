Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927D7228FC4
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGVFe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:34:59 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:46427 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgGVFe5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:34:57 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P3-0005QS-R0; Wed, 22 Jul 2020 00:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g4oX3BgZ9ods+C0xQm/7CSC1FN00hD+kHzy8iHeuEbg=; b=RdS2JTEVFU47LeCwVu4BND8wHe
        YTfKSYZ7Gs/FtCIIe69A68i1eHWHYMsvz2hOh9zbzvebGgQcMYTZo5YN2EO4eoVN6svKVPNL6A+h5
        edsWW9gnxw9tUJRp7MPYY/c6oYPG95zP9ZIzNvATS2hZuxNrto3JVBjYa1etXDjUD2P6CgPMzDbBS
        jBcilj9IVGz2FIjNrAaru+lWqWt/FzgtWZowEUMEFlb5f7B06/pxL1YltDPNGYrCjHIM+vRmLdKEo
        eH5VzDawJ4ixReRqPbrRSm2tueglFoungpSDt1biPDrl+4u6m4I+6LsRksZ+oZzcro++c7a1rHZr6
        qPADgIQA==;
Received: from [174.119.114.224] (port=44150 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P3-00045O-GS; Wed, 22 Jul 2020 01:34:53 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/5] libtirpc patches
Date:   Wed, 22 Jul 2020 01:34:40 -0400
Message-Id: <20200722053445.27987-1-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVco68FsdzuGD4
 737Z8XZT0ETNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KnRr9dv6aS/XsdM3hwL/Vxz9G
 0IA9bRwRct9JixjrSnwE9+MNv0Z9Z/ftUlQdQf4t0vBWG099Hxh0Nb9o6T55Sb4hKsV7vZ7I7qfm
 2H1RjeqTlVJu4AFLIxXDoYUKrmuq1/BgStvhQrzEV/3sSgXiDA8Wchfv6rsJV69dwwRye5Fqf5gk
 ygI/REKLXOuXEMRCFDpXnW7vq/flvXA178y90oxHpGdcOo7PShBgpIzYxnXDldmsGq7kDyH0ew4I
 Dw+CACkJUHU38G0nImq/tiQjLLdHRLp5rVU0FqkdDCRmJ2BgSGUuK0YJtRg9EDez7Ku5DKDi4xrE
 c/zFBOmiGaAnFDV0eGlRuLVR1NWZXcsvs30x4KEUiJDRsmQ5HT3VKkMngMDkh+x5vuoVP4y7XWE4
 hh0K7aaWJsTJLX1F+5HwflHXs2KsRjKrCowEavDwQuKoFXnYnNNCNwgP2MQ1gciXBQ+q69NBV6o+
 QUIkaY4elbUUfTr26s/5PSZcfEU2ZCQrKTjECb0PwpN4olPuA0AI9+ulfm1tbbH4NsTwNgi2MDfQ
 SgMHurv2dxDwgdigsjtQ+68vj/Zr5D+lbOOtFT7Wk7yyri//9sNP2pYqoDB9thlqQWNDIOqHl/su
 Cgr6cqCgExuGjqPWk46FoQRGMpCW/+R/y847K936Ks6Fu8uhrJCPPZiKGTzb2X0CsNjV/ErluLyc
 9vuJG2bK/+wZJ/tpqBD2vvTWdasCwvCiFabvBgsCDk9os2Xse5/Y5KszrdTTybAFkn6/xPgn4DFt
 oWH9FBxwEiTVJqDh0qKoKsXx5llbf0i+3nLTOhKYZNMsjrDtoZv1Jq9xAcIT3xed7wGmqxx1XE8q
 iL+B/6VrQyOXCK5m866CV4x+8EDWP5Dt8orPKygtVd32N1s3THnwUUyY+7Kh11Xmv+TszuJqCiWT
 xnCBYfMJKY6wXFFS639jBMHAePQ44lqMDpyryPGheI8wLmjmUhnjY+kgx3rv6P0wL+KoM0pOgvbF
 CaqvXm81A7xJ
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While running valgrind on various nfs-utils programs, I came across a leak
while destroying a svc_dg object.

Second, I noticed that pollfds were being reallocated a dozen times, so
added an optimization to batch the allocations.

Third, I added destructor functions to clear up some of the static allocations
on exit. This is mainly to help with running valgrind. Not too important, more
of an RFC if it's desired.

Forth, I noticed that the comments expected the main thread to use the static
variable, instead of thread specific data but wasn't doing that. The last two
patches implement that. Also helps with valgrind as TSD is not destroyed on
the main thread.

Thanks,
Doug

Doug Nazar (5):
  svc_dg: Free xp_netid during destroy
  svc: Batch allocations of pollfds
  Add destructor functions to cleanup static resources on exit
  Add ability to detect if we're on the main thread.
  Use static object on main thread, instead of thread specific data.

 src/auth_none.c    | 14 ++++++++++++++
 src/clnt_dg.c      | 12 ++++++++++++
 src/clnt_vc.c      | 12 ++++++++++++
 src/getnetconfig.c |  3 +++
 src/mt_misc.c      | 20 ++++++++++++++++++++
 src/svc.c          | 35 ++++++++++++++++++++++++++++-------
 src/svc_dg.c       |  2 ++
 tirpc/reentrant.h  |  1 +
 8 files changed, 92 insertions(+), 7 deletions(-)

-- 
2.26.2

