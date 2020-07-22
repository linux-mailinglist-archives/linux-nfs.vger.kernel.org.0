Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5321B229024
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgGVFyC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:54:02 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:53259 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727950AbgGVFyB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:54:01 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hW-0005in-Si
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 00:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i4bDywXUJF5cJEnab3z+6ZwBOF7rP1T6xydM4g9XJss=; b=pizUicl/mR4jOPRYkPvkoiiZLI
        ZKlLx4CrSEIZfrumXdWMXxOBERT0jQb3n1VLkoluRxYOmDncvVymddk0iVDBXQOD47ZTKIwh/BngX
        ny8e/4Duiq0vpHIOmisfNcEmdmd6+5Fp99WGQjqjBIU15JVXf+g4MjI9BvXiP2DDlxYyWYR3Xpni/
        fylKcrpDHL0rshVF9KUOfzPCrZUC+fnneDWaxJMTcFNr9Ay5dM7Jh0TG9OxGKx9gC2norK3FTP7Ug
        DuhmRuycGGffD0JPg+Cb7IiFfsdm8laEetLSAiI/DnAwgyR5wF44Dut5qgq5cHn7fKbwwhWy/rWCH
        gWn0YgPQ==;
Received: from [174.119.114.224] (port=44746 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hW-00076P-Mr
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 01:53:58 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] nfs-utils patches
Date:   Wed, 22 Jul 2020 01:53:50 -0400
Message-Id: <20200722055354.28132-1-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVa+ZbtEPbi8co
 XoLSqaX7L0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIboUsG4MHjF+0dhyS0pM6KqwD+Ufwmnv2XpsoA/vlp5nXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSOp
 e12oc1JFRdloamUrN3pp9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5hgC6l
 piAGkE2keHCfgDkMTx4/qLiqb+jSWNwzHM9ewSP5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
 FubLd8OpyKA69LF1Ge2GaGfxmfr6K2lXCppCFhOH1qLPVvOyhENX6cHY1RZ9qv4kihn2llwcIfe9
 qSdMLqKquuUrXWpOB0fQQI8VICRbS6zGNgmkrLchyjwyJsS12kHj54zW1GIRK0UT0GXzK7XVSbOa
 O4t6datJIW5RtosbtmTCpMB/
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A few more as I progress through all the utils. There isn't any
dependency on the previous patches.

Although idmapd client support is depreciated, the kernel still falls
back to using it if the upcall fails.

Wasn't originally going to send the last patch upstream, but figured
might as well, and let you decide if it's wanted. Basically allows you
to load the plugins from a development source tree for testing instead
of requiring them to be installed in their final location.

Thanks,
Doug


Doug Nazar (4):
  exportfs: Fix a few valgrind warnings
  idmapd: Add graceful exit and resource cleanup
  idmapd: Fix client mode support
  nfsidmap: Allow overriding location of method libraries

 support/nfs/exports.c          |   1 +
 support/nfsidmap/libnfsidmap.c |  40 +++++--
 utils/exportfs/exportfs.c      |   7 +-
 utils/idmapd/idmapd.c          | 211 +++++++++++++++++++++++----------
 4 files changed, 183 insertions(+), 76 deletions(-)

-- 
2.26.2

