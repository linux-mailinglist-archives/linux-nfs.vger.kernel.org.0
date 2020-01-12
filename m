Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1193713853B
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2020 07:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgALGDw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Jan 2020 01:03:52 -0500
Received: from mail3-bck.iservicesmail.com ([217.130.24.85]:58558 "EHLO
        mail3-bck.iservicesmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732249AbgALGDw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Jan 2020 01:03:52 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jan 2020 01:03:51 EST
IronPort-SDR: RpLFGXv76/z5RKKBPnwtPx0JJ6vhNaEJRTODxPycGCUTFjc7XsvV//Mad3rzSIk5Pc6NO0b0NN
 EA3dr3spLPfQ==
IronPort-PHdr: =?us-ascii?q?9a23=3A+KQLnxRYhDBCRtwRnZEX5VBBadpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybBON2/xhgRfzUJnB7Loc0qyK6vumAzJeqsfZ+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgIpvJqk1xx?=
 =?us-ascii?q?fVv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/GfQhsJtkK1Uuhehphxmz4PKZ4GVLuJ+fqTHfdwAWW?=
 =?us-ascii?q?pOQN9dWDJHAo+lc4YPE/YBMvxEoIn9uVQOqAWxBQ+wBO/21DBIgGb606o90+?=
 =?us-ascii?q?QnDw7H3BUsEMwIsH/JqNn4OrseXfywwKTO0D7Nbe5Z2S3l5YbGch4hu++CU7?=
 =?us-ascii?q?Ftf8Xe1UYhGBjIjkmSpIP5Iz+ZyvgBv3ad4uF9VeyvkWknqwRprza12Mgslp?=
 =?us-ascii?q?fGhpgIwV/E8iV5xok1LsC/RU5jf9GkDIVftzuUNotxRMMiTHpluCYhyrIdpZ?=
 =?us-ascii?q?G3ZjQFyJMixxLFa/yHcJGF7xT+X+iSOTd1nGxpdK+9ihqo7EStxPHwWtOq3F?=
 =?us-ascii?q?tFtCZInNnBu3YQ3BLJ8MeHUOFy/kK51DaK0ADc9/9LLFgvlareN54h2rkwlo?=
 =?us-ascii?q?cPsUjbHi/5hkH2jKiOe0Uh4Oeo6uDnYq/4qZ+YK4N5hRvyMropmsOiG+s4PA?=
 =?us-ascii?q?8OX26F9uimyrLj5lX1QLRMjvIojqnUqI7WKdkZq6KjHgNY3Jov5wyhAzqpyt?=
 =?us-ascii?q?gVk3kKIEpAeB2djojpP1/OIOr/Dfe6m1msiClkx+zYMb37DJTNKX7DkLj6cL?=
 =?us-ascii?q?Z98E5T0xY8wcpD6JJTD7ENOvLzWkzpuNzCEhA5KxC0w/rgCNhl0oMeWGSPAr?=
 =?us-ascii?q?KWMa/Lt1+I6PkvLvKSZI8apjn9MeIp5/3wgn8jn18SY62p0YEQaHCiEfQ1a3?=
 =?us-ascii?q?meNH7thMoRVGEEpSIgQ+Hwzl6PSzheYzC1Ra1v3DwjDJOaCtL7S5ygmvS+2y?=
 =?us-ascii?q?G0VslOa3xLEE+LF3jodIWfUfwkZyebI8snmTsBA+uPUYgkgCmjqALgg4VgKO?=
 =?us-ascii?q?WcrjUVqZ/5y99z6MXTjhs5szdzCoKd0DfeHClPgmoUSmpvj+hEqktnxwLYif?=
 =?us-ascii?q?B1?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GeAgD8tBpelyMYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBGwgBgSWBTVIgEpNQgU0fg0O?=
 =?us-ascii?q?LY4EAgx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQE?=
 =?us-ascii?q?FBAEBAhABAQEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVO?=
 =?us-ascii?q?DBIJLAQEznW4BjQQNDQKFHYJLBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ?=
 =?us-ascii?q?/ARIBbIJIglkEjUISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAO?=
 =?us-ascii?q?EToF9ozdXdAGBHnEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GeAgD8tBpelyMYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBGwgBgSWBTVIgEpNQgU0fg0OLY4EAgx4VhgcUD?=
 =?us-ascii?q?IFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABAQEBA?=
 =?us-ascii?q?QYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVODBIJLAQEznW4Bj?=
 =?us-ascii?q?QQNDQKFHYJLBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ/ARIBbIJIglkEj?=
 =?us-ascii?q?UISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAOEToF9ozdXdAGBH?=
 =?us-ascii?q?nEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,424,1571695200"; 
   d="scan'208";a="323202778"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 12 Jan 2020 06:58:48 +0100
Received: (qmail 24397 invoked from network); 12 Jan 2020 05:00:21 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-nfs@vger.kernel.org>; 12 Jan 2020 05:00:21 -0000
Date:   Sun, 12 Jan 2020 06:00:19 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-nfs@vger.kernel.org
Message-ID: <12070118.460790.1578805221062.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

