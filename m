Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC85156872
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2020 03:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgBICxA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 8 Feb 2020 21:53:00 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:11864 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgBICxA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 8 Feb 2020 21:53:00 -0500
IronPort-SDR: Jh8HV9cbBVC2zOz1yLKZbDFyxmCYS5AFjlqFL0Zl9PCusUooTWd73ElLoYH6fqGYeXXlViVLYl
 4IDRxTCXPLrw==
IronPort-PHdr: =?us-ascii?q?9a23=3AualaSBAe4MhbjbGCRL9FUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT5pMbcNUDSrc9gkEXOFd2Cra4d16yL4+u8BiRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMKY8xx?=
 =?us-ascii?q?jGrnZHeeld2GdkKU6Okxrm6cq84ZBu/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4cSG?=
 =?us-ascii?q?FcXMheSjZBD5uyYYUPFeoPI+VWoZTyqFQSohWzHhWsCeHzxTNUmnP6wbM23u?=
 =?us-ascii?q?I8Gg/GxgwgGNcOvWzOotrrKKcdT/q1x7TIwjXEafNW1ir25Y/Qch8/vfGDQ6?=
 =?us-ascii?q?hwcMTWyUkpGAPIlU6fqYv4MDyP1+UNtG6b4PR6We2zjG4nrhh8rz6yzckvko?=
 =?us-ascii?q?nEnpwZxk3G+Clj3Yo4K8G0RFRlbdOrCpdduSGXOo1rSc04WW5oojw1yrgetJ?=
 =?us-ascii?q?6+eygF1YooygbEa/yCb4iI+hXjVPuNITtghHJqZra/hxGq/Eil0OL8V8200E?=
 =?us-ascii?q?xUoSpBjtXBuWoB1wLU6seaUPR98ECh2TCR2AzJ9O5EOlg4lavdK5E/3r49jo?=
 =?us-ascii?q?QfvVnBEyPshUn7grOael869uWn8ejqbLXrqoeZN4BuiwH+Nqoumta4AeQ9Kg?=
 =?us-ascii?q?UOR3aU+fii273580z5R7NKjvItn6bCt5DVON4Up6++Aw9TzIkv8QqwDzCj0N?=
 =?us-ascii?q?gAh3kIMEpFeA6bj4juI1zOJPH4DfGig1WjiTtrwf7GPqb6D5XTIXjMjq3hca?=
 =?us-ascii?q?x+60FC0gozy85Q55ZOBrEGOvLzVRy5iNuNCh4/Lhzxxej8IMty25lYWm+VBK?=
 =?us-ascii?q?KddqTIvgyy6/orMtWLMbcYpDvnY8ci4fGm2Wc0hVIHYq6v0psMYnu4HdxpJk?=
 =?us-ascii?q?yYZTznhdJXQkkQuQ9rdOH2hUfKbjlVaD7mR68g6yskD4SpJY3ESom/h7qMmi?=
 =?us-ascii?q?y8G8sFNSh9FlmQHCKwJM2/UPAWZXfKLw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FJbQDXcz9eeiMYgtlmHQEBAQkBEQU?=
 =?us-ascii?q?FAYF7AgGBPQKBVlINExKMZIZwgU0fg0OLaIEAgzOGCBOBZw0BAQEBARsaAgE?=
 =?us-ascii?q?BhECCRiQ8Ag0CAw0BAQUBAQEBAQUEAQECEAEBCwsLBCuFSkIBDAGBayKDcCA?=
 =?us-ascii?q?POUpMAQ4BhiIBATOlU4kBDQ0ChR6CUgQKgQiBGyOBNgIBAYwhGoFBP4EjIYI?=
 =?us-ascii?q?rCAGCAYJ/ARIBboJIglkEjVASIYk/mDCCRAR4lWuCOAEPiBGENQOCWA+BC4M?=
 =?us-ascii?q?dgwiBZ4RSgX6fWIQSV4Egc3EzGiOCHYEgTxgNnGICQIEXEAJPhDuGNoIyAQE?=
X-IPAS-Result: =?us-ascii?q?A2FJbQDXcz9eeiMYgtlmHQEBAQkBEQUFAYF7AgGBPQKBV?=
 =?us-ascii?q?lINExKMZIZwgU0fg0OLaIEAgzOGCBOBZw0BAQEBARsaAgEBhECCRiQ8Ag0CA?=
 =?us-ascii?q?w0BAQUBAQEBAQUEAQECEAEBCwsLBCuFSkIBDAGBayKDcCAPOUpMAQ4BhiIBA?=
 =?us-ascii?q?TOlU4kBDQ0ChR6CUgQKgQiBGyOBNgIBAYwhGoFBP4EjIYIrCAGCAYJ/ARIBb?=
 =?us-ascii?q?oJIglkEjVASIYk/mDCCRAR4lWuCOAEPiBGENQOCWA+BC4MdgwiBZ4RSgX6fW?=
 =?us-ascii?q?IQSV4Egc3EzGiOCHYEgTxgNnGICQIEXEAJPhDuGNoIyAQE?=
X-IronPort-AV: E=Sophos;i="5.70,419,1574118000"; 
   d="scan'208";a="334382029"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 09 Feb 2020 03:52:59 +0100
Received: (qmail 8230 invoked from network); 9 Feb 2020 00:49:09 -0000
Received: from unknown (HELO 192.168.1.163) (apamar@[217.217.179.17])
          (envelope-sender <peterwong@bodazone.com>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-nfs@vger.kernel.org>; 9 Feb 2020 00:49:09 -0000
Date:   Sun, 9 Feb 2020 01:49:06 +0100 (CET)
From:   Peter Wong <peterwong@bodazone.com>
Reply-To: Peter Wong <peterwonghsbchk@gmail.com>
To:     linux-nfs@vger.kernel.org
Message-ID: <23499023.233647.1581209349556.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings,
Please check the attached email for a buisness proposal to explore.
Looking forward to hearing from you for more details.
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

