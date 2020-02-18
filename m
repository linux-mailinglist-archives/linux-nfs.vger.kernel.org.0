Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E033163741
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2020 00:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgBRXbL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Feb 2020 18:31:11 -0500
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:56795 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728132AbgBRXbL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Feb 2020 18:31:11 -0500
X-Greylist: delayed 2235 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 18:31:10 EST
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1j4BkV-00080r-Jx; Tue, 18 Feb 2020 16:53:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Rr2jI9Yy580Si3jOwA46MiaXicERKf7za6TWV5lxySU=; b=mZu9NEqkX29qN4AUYF1YzcevM/
        LBwP19Z1jPauY9gWJIknLO8kYqw2ZRDUtKgD4I5pS0c1d2Xli+EiLvqJnNkAAQ82moJuJwnGiNo3N
        tuvdoPrGd/LG8Lh1vf2qymST9qcxp7hbDQjH/W6mPirVxmpTx5ml5dIRUqbjJsYksWwqocD0CwwJ1
        ZBveXJwHrN3DdBYtpJ4mfIK+UZ+9Hgv5DqcCTZ2z3nhSxv6PEWhUsm9OMYjXC14HyySAvCdw/05hd
        392lK0F7OR+/uALkzF+QnbjwYWZozOLsovJwmVKQSTCOZXoI7ssuP4xMhL+UrF7vg1Y21ciI3FG0n
        ykFQuecg==;
Received: from [174.119.114.224] (port=60712 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpa (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1j4BkU-00F1xG-Vj; Tue, 18 Feb 2020 17:53:51 -0500
From:   Doug Nazar <nazard@nazar.ca>
To:     Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc:     Doug Nazar <nazard@nazar.ca>
Subject: [PATCH 4.9] NFS: Don't map array page twice
Date:   Tue, 18 Feb 2020 17:53:31 -0500
Message-Id: <20200218225331.23665-1-nazard@nazar.ca>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0UaqOYGQPGxXNcBH7FeyDZOpSDasLI4SayDByyq9LIhV47rokcCtedwg
 KA+JHErNn0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KTnKS7poOVDghjkMu3yyyMVh2
 XfM+l1y/79y2j0cw+9E6jxCl2Yk0E4MGrt82bPpUvMRcVM5ZC7b27X4acKvUNea/B7VvovszkhKe
 Buv5yk7qStb+bRpiAvVxcoSihgcWTvyPNezh4eXIcvclZsk4Ck9kN7MM31r8n6t5T2S20aVQ31no
 MrjOX5l5W3geIorHzUVyzRILyduVl6cJUh6/qYg/tdrl3Od/7IIsfBFC3FHWVSYqYNPiz/7KZf4x
 yf0nUPZYndKUcK2z43jJAOe4v8AELKvSa9IcHU8w8kr8LAGfoq7PWbpuMXneMDbS+UiMrJ6UFTYW
 JmrE41TM+DFHrgx4lxeSTlVkJxPMSuqJXW6PzEbYdsToBfYWYQnYk1DF2m+fD6li2HwbRxBcHYne
 1pP0NLR2QHgKfCXvEHmSvRCjCKQGgQpxJtEAuXCKGVsLWl1WNEfNN2fPdebTPlAK6/Ss8m11cqGQ
 hR1uMlxxsBNsQjT7WqJkIgPmkLSafWIN79efSlj/BZbvF8RtPA8ciEcX2oSLQAVbMixIHRqBsPnq
 3Xht9OeQCftbpWUle2yeR2XWF6vZ2wfWC27hHZWRh+cQtGmoJkZh7BLMXqoNJQEidMIBN1hPFaWS
 vxHkOIfJTee5cfSfb7q9IkHnd+cJP5ROMiHspakG3u2oY4VIRQEHmFDqewO9xyOqCYO8P1aHE1fL
 3NZ3izOO6oS4ge8Cm8ueI55niwPE6CvD8QGOzIqWQLBpuVdYol1mYtrA6DTO+sySutMblxptwYr9
 XZBV7aXs7YSgTgvSr65i5Mt17HlKZTXdiXCG829KGuYRWKUnsWOvdnNKb/Dj4yAPeBxfOnLYM3A6
 BXfvel8OEFDbU52XiIfzuD0a832HdaHasPuOWhInFDkaeii7+isbE/cfevWXbal9mj06LuoJ/Kaj
 To0Q9r701nWrAsLwohWm7wYLSf1rWt8UKdIyxz68TCs2y/lowQDAiQHyOVG8kOYj2zUBh7WON5oB
 bbv2MybeSVS6giEI2S0vTI7QrI72L6lPtB88WDjqPOTTBv7iA1r6uVWXOa0PpbOye6Agy7do5qZg
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When 4b310319c6a8 ("NFS: Fix memory leaks and corruption in readdir") was
backported (as 67a56e974317 in 4.9-stable) it added a kmap(page), however
in this branch, the page has already been mapped as the array via
nfs_readdir_get_array().

Fixes: 67a56e974317 ("NFS: Fix memory leaks and corruption in readdir")
Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 fs/nfs/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c2665d920cf8..2517fcd423b6 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -678,8 +678,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 		goto out_label_free;
 	}
 
-	array = kmap(page);
-
 	status = nfs_readdir_alloc_pages(pages, array_size);
 	if (status < 0)
 		goto out_release_array;
-- 
2.24.1

