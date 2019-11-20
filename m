Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371B3104391
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 19:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKTSnU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Nov 2019 13:43:20 -0500
Received: from mails1n2-route0.email.arizona.edu ([128.196.130.79]:13410 "EHLO
        mails1n2-route0.email.arizona.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbfKTSnU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Nov 2019 13:43:20 -0500
IronPort-SDR: dd8PZixLCdvkl63BkRPmhIi9fiVRHY2HX4M1cPhZ68vYTu4uZsWMXp5b2LWzm/gR+mu33JkhQP
 D9i7ckqeDhtQ==
IronPort-PHdr: =?us-ascii?q?9a23=3AMFSWLhzG1sRMlRXXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd1O4WIJqq85mqBkHD//Il1AaPAdyArasZ06GP6vuocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi2sQndudQajZZsJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlSEKPCM7/m7KkMx9lKJVrg+/qRxxwIDabo6aO/hica3SZt4aWW?=
 =?us-ascii?q?hMU9xNWyBdHo+xbY0CBPcBM+ZCqIn9okMDoAW+BQa2AuPg1ztIiWHs3aYn1O?=
 =?us-ascii?q?kuCxzJ3AkhH9IIq3nUo8v6NKEVUeCw0qbE1y/Mb+lX2Tb874jIdAoureuSUr?=
 =?us-ascii?q?1tbMrc0E8iHB7GgFWIsYHpIi+Z2v4Qv2WV7OdsT+CihmE9pw1soTWixMEhgZ?=
 =?us-ascii?q?TTiI0P0FDL7yB5zZ4wJd2/VUF0f8apEIBVtyGGL4t2Rd4iQ31wtCY61LIGvZ?=
 =?us-ascii?q?m7cTAOx5g62xLTceGLfoaL7x75VuucLi10iG9mdb+9gRm+6UmgyuviWcmoyF?=
 =?us-ascii?q?tGszZJnsPRun0D1BHf8MqKR/Rn8ku82juC1Rjf6uReLkA1karbJYQhwrk1lp?=
 =?us-ascii?q?cLq0vMAyr2mETwjKKNeUUr5O6o6+PiYrr4vJOTLZV0igD/M6QpnMywG/40PR?=
 =?us-ascii?q?YTUGiG4ei8zqHs/VXlQLVWif07iq3ZsJHcJcQGqa+1GglV0og46xukETem38?=
 =?us-ascii?q?oXnWMdIFJGZh2HlY7pNE/KIPziCve/mVusw39XwKXCP7v8EtDLIGPrjrjsZ/?=
 =?us-ascii?q?B+5lRaxQ51yspQtLxODbRUC/L6XEP1ucaQWhY1Ng2y6+nqDtJ428UXQ2OdBa?=
 =?us-ascii?q?mQdq7erAnbtaoUP+CQadpN637GIP8/6qu2gA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BkCwAXiNVd/7tKigoNWBwBAQE4AQQ?=
 =?us-ascii?q?EAQECAQcBAYFYAYE0AocurDsBCAEBAQ4vAQGENgEBCAKCSzgTAgMNAQEBBAE?=
 =?us-ascii?q?BAQEBBQICAYVXgRoWAYFiIoJ1AgEDIxVRCxoCJgICV4M7glOvcHWBMoVOgns?=
 =?us-ascii?q?fCYFVgQ4mAgEBjCx4gQeBOAyCXz6FEoJDgl4EgTqIb4w1RpcKH4IWgRwFX5N?=
 =?us-ascii?q?JBhuCLgGCFJVRpXmDA4FpgXpNJROBWYFPTyWVLItChAABAQ?=
X-IPAS-Result: =?us-ascii?q?A2BkCwAXiNVd/7tKigoNWBwBAQE4AQQEAQECAQcBAYFYA?=
 =?us-ascii?q?YE0AocurDsBCAEBAQ4vAQGENgEBCAKCSzgTAgMNAQEBBAEBAQEBBQICAYVXg?=
 =?us-ascii?q?RoWAYFiIoJ1AgEDIxVRCxoCJgICV4M7glOvcHWBMoVOgnsfCYFVgQ4mAgEBj?=
 =?us-ascii?q?Cx4gQeBOAyCXz6FEoJDgl4EgTqIb4w1RpcKH4IWgRwFX5NJBhuCLgGCFJVRp?=
 =?us-ascii?q?XmDA4FpgXpNJROBWYFPTyWVLItChAABAQ?=
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="436224094"
Received: from on-campus-10-138-74-187.vpn.arizona.edu (HELO [10.138.74.187]) ([10.138.74.187])
  by mails1n2out.email.arizona.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 11:43:18 -0700
From:   Chandler <admin@genome.arizona.edu>
Subject: Re: NFS hangs on one interface
To:     linux-nfs@vger.kernel.org
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
Message-ID: <a790a87f-4062-0c8c-0957-2d59df64a870@genome.arizona.edu>
Date:   Wed, 20 Nov 2019 11:43:18 -0700
MIME-Version: 1.0
In-Reply-To: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Seems the problem was a mis-matched MTU setting with the switch.  Now that the port on the switch is set to 9000, everything is working.  Thanks for all your help.

