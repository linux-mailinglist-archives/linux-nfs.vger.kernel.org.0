Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95240113F58
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2019 11:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfLEK14 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Dec 2019 05:27:56 -0500
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:59801 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728707AbfLEK14 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Dec 2019 05:27:56 -0500
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <nazard@nazar.ca>)
        id 1icoMS-0004o0-Ic; Thu, 05 Dec 2019 04:27:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g5FvqhTL8V5YUUfVklHRmdVlmQ1Wud1mD6SZT9y6qeE=; b=BcQQ78w5urjTY1uf/qKc1tABzJ
        a+ss4nHABEQSvdXHql8MKQb0zfK2FvlY0LOd5FV+nos7Nkrb/fFGOoyH0ZITU+MBzbi84b1doHpes
        DnqcfZa3lE6MUGYia/LHfKcFZ5daxgWIwKGZpnBzRit+HulTckyVl0u79nWOP2zEYeuAQDdkwVhnZ
        YCYwp6btEwuoSx8vmj6s3kd77F0bE1AaZLmLFNrb7QEvugU2CiDJfasMBoi0lrwZ7VzAbRiMma+zB
        vaHfAPV+0BNHYMUVB1QwoxMeF4cDfiUBls5zTdYurcCJ3D+b9AW9DOhIUDqZ0djv5dSyyW2KGUJU0
        Lpa5wdOA==;
Received: from [24.114.72.155] (port=37390 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpa (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1icoMS-00075x-4y; Thu, 05 Dec 2019 05:27:52 -0500
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>, Doug Nazar <nazard@nazar.ca>
Subject: [PATCH] Disable statx if using glibc emulation
Date:   Thu,  5 Dec 2019 05:27:36 -0500
Message-Id: <20191205102736.24314-1-nazard@nazar.ca>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: relay
Authentication-Results: arandomserver.com; auth=pass (login) smtp.auth=relay@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0fKZ8wcD78QFAaYhvfMzLIKpSDasLI4SayDByyq9LIhV5Yahflob5aAg
 zgTTBMBoMkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTh5H
 bSAV/Mx/EYvM1H4+en0AxUtRo2eo7JXmMD/kBY54TX+DNB8zzxX/4FjqtJmb5HrHOgryQr3fhcqf
 yPnK+XABzS5fPHINUJxVzZg1ZLp9gmsYntIZvASFzmmwEK8xkpmNQB3hWTYq/vzakcc65ZBQkiNC
 3M7Pj/MY9gGLjh/nwB5YOcnLTEWr5QFxf29u2b0ZFs7AIGlqJcSMQo9hh7aOmrbMWhZFkvyjvYIF
 be8tdb9BwqvSI91oKEKHszPrHLIoTCzQ7XvYo5qydvprZHcSCR22vShmebXILNDFNYkR6LCtYz5o
 yWoRpE2M2XALSMDT9ZG0CmXc0v4tKHsUSjuO8OL3MKmWpyx7GTPK+LOWY5R6BpcvGp3jcY/qUcse
 gxHyS9oTCOMgg0kq/x8Q8jegKor5vGLGjUegAaOB9ePyJLFZV2VsWrEXxYzPJvIeyCEnVSsgPP/M
 gqSGMx92qX+/Ib/3gD1xdv4OjYexFN7ik4oYRgdX/aeSLw4ZD+8uTG/yF5Sslr7rjwGaoPhs3lRX
 yXnXny2JA4iXRtmvwJUPkDzLsegeIf5jR5PNTlF6ReCprMAKLZ9Vvl2XZc6+7+zUzX99k5ROK7DU
 2cuVvM4pN2jrzuqNLgr3QpfT+A5/9mbzroJXjH7wQNY/kO3yis9UoFIvD3sIcP1fhJPM6B/8NA/2
 WRcsjpniTU5VYMta6tks3e/xYSLn+HJoEjOfExoxcfxmM3wdGChc6hHRfRowObH2LW6BIAQW76wb
 eBOhgzcKVNeVJ9BXyu9+ceCqThQaHAwskslMOiSjwnYcoQfxx57gE89ByJNnvoZD/j4xXaiZ9OGv
 SyF6jGxmwlE+D33NBz6C+Mu+hGpwr7PBqmKnubcolFl/rX+2ReQklqJDAdqlKemfur/8qYsUn20e
 BeH3y8h6dUrDs43Vm7LtiRHY
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On older kernels without statx, glibc with statx support will attempt
to emulate the call. However it doesn't support AT_STATX_DONT_SYNC and
will return EINVAL. This causes all xstat/xlstat calls to fail.

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 support/misc/xstat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/support/misc/xstat.c b/support/misc/xstat.c
index 661e29e4..a438fbcc 100644
--- a/support/misc/xstat.c
+++ b/support/misc/xstat.c
@@ -51,6 +51,9 @@ statx_do_stat(int fd, const char *pathname, struct stat *statbuf, int flags)
 			statx_copy(statbuf, &stxbuf);
 			return 0;
 		}
+		/* glibc emulation doesn't support AT_STATX_DONT_SYNC */
+		if (errno == EINVAL)
+			errno = ENOSYS;
 		if (errno == ENOSYS)
 			statx_supported = 0;
 	} else
-- 
2.24.0

