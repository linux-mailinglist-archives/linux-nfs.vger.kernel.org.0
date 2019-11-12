Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A818F9CCC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 23:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKLWOl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 17:14:41 -0500
Received: from mails1n2-route0.email.arizona.edu ([128.196.130.79]:7126 "EHLO
        mails1n2-route0.email.arizona.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfKLWOl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 17:14:41 -0500
IronPort-SDR: S/iBOUKaGLB569LQZe7XQ2XG7hZGGvF9ys0rSPyJW4+mT1BkO9rMycFKBcUiSmFq/K01jLQtVU
 dMhC5qQhiRIA==
IronPort-PHdr: =?us-ascii?q?9a23=3AdWbiGRyO0jXhg6vXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+oTIJqq85mqBkHD//Il1AaPAdyArase2qGP7fiocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBmoqQjdudQajIp+Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlSEKPCM7/m7KkMx9lL9VrgyvpxJ/wIDabo6aO/hica3SZt4aWW?=
 =?us-ascii?q?hMU9xNWyBdHo+xbY0CBPcBM+ZCqIn9okMDoAW+BQa2AuPg1ztIiWHs3aYn1O?=
 =?us-ascii?q?kuCxzJ3AkhH9IIq3nUo8v6NKEVUeCw0qbE1y/Mb+lX2Tb874jIdAoureuSUr?=
 =?us-ascii?q?1tbMrc0E8iHB7GgFWIsYHpIi2Z2+cXv2SG6+dtVPijh3Mopgx1uDSj2Mghh4?=
 =?us-ascii?q?nPi4kI0F7L7z95z5wwJdCgTU57ZsOrH4VIuiGBMot2XtsiQ2Z1uCYm0rEGuY?=
 =?us-ascii?q?C0fCwNyJk/wxHTduKLfouS7h7+UOucIC10iG9qdb+7nRq+70etx+36WcWs0V?=
 =?us-ascii?q?ZKqDRKksXUu3wQyRDe6dKLRuZ580qgwzqDyg/e5+VeLUwqmqfWK4YtwrsqmZ?=
 =?us-ascii?q?oStUTDEDX2mELzjKKObEor5+2o6+XhYrj9qZ+TKYl0igb7MqswgMCwG/44Mg?=
 =?us-ascii?q?kPXmic/+Szzqfv8lPkT7VXlvE2iLXWsIjGJcQHoa60GwtV0ocl6xaiADaqyd?=
 =?us-ascii?q?IYnXccLF9eZhKHgJbmO0vULPD7E/i/mVKsnylvx/zcOb3hGJrNJGDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwN9F6JJUDrYBLenuWk/0tdzXEh85PxaqzOn6FdUunr8ZDEWLDa?=
 =?us-ascii?q?bRE6TIt16F+PksKuiFLNsctzL6A+Ug5vXuy3I1hAlOU7Ou2M48aHm+EvBrOQ?=
 =?us-ascii?q?3NaHbpg9EpHmoMuQ8zCuXwiU+FVzcVanqvCfFvrgonAZ6rWN+QDrumh6aMiX?=
 =?us-ascii?q?+2?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A+BQDGLctd//WVxIBmDhABCxyFXyA?=
 =?us-ascii?q?ShFOJA5cLhDKIAgEIAQEBDhMZAQIBAYRAAoJBOBMCAwsBAQEEAQEBAQEFAgI?=
 =?us-ascii?q?BbIRrgxMignUGIxVBEAgDDQEMAhIBEwICVwaDNYJTJa9ugTIahTSDBh8JgVW?=
 =?us-ascii?q?BDiiMLHiBB4E4gms+hC9eAoJGgl4EgTmIbIwrRZZ7H4IQgRsFX45GhHkGG4I?=
 =?us-ascii?q?tAYITiX8DizaoZYFpIoFYTSUTgVmBT0+fSlshgTUIARUIEgEKAY1NDReCGgE?=
 =?us-ascii?q?B?=
X-IPAS-Result: =?us-ascii?q?A2A+BQDGLctd//WVxIBmDhABCxyFXyAShFOJA5cLhDKIA?=
 =?us-ascii?q?gEIAQEBDhMZAQIBAYRAAoJBOBMCAwsBAQEEAQEBAQEFAgIBbIRrgxMignUGI?=
 =?us-ascii?q?xVBEAgDDQEMAhIBEwICVwaDNYJTJa9ugTIahTSDBh8JgVWBDiiMLHiBB4E4g?=
 =?us-ascii?q?ms+hC9eAoJGgl4EgTmIbIwrRZZ7H4IQgRsFX45GhHkGG4ItAYITiX8DizaoZ?=
 =?us-ascii?q?YFpIoFYTSUTgVmBT0+fSlshgTUIARUIEgEKAY1NDReCGgEB?=
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="434089651"
Received: from unknown (HELO [128.196.149.245]) ([128.196.149.245])
  by mails1n2out.email.arizona.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 15:14:40 -0700
Subject: Re: NFS hangs on one interface
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
 <20191023171523.GA18802@fieldses.org>
 <b6248a82-1f1a-7329-5ee0-6e026f6db697@genome.arizona.edu>
 <YTBPR01MB2845B12E9C59F837FE35F40DDD650@YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM>
 <82ee292f-f126-9e9f-d023-deb72d1a3971@genome.arizona.edu>
 <1079a074-7580-e257-8b52-6e48f8822176@genome.arizona.edu>
 <CAN-5tyExtO_HRGYrqq7UTObrHNsTp7UqwW=Kg4CFM3q-OnaUiQ@mail.gmail.com>
 <49472814-8dcd-4594-d48e-be4c1d9a8d8f@genome.arizona.edu>
 <CAN-5tyGD3hNcG7=+xdB4Bs1OCCUoLzZ5ocsJusuxd3n3+x=7gw@mail.gmail.com>
From:   Chandler <admin@genome.arizona.edu>
Message-ID: <f3b837d5-d767-959d-f274-28d4e4507539@genome.arizona.edu>
Date:   Tue, 12 Nov 2019 15:14:39 -0700
MIME-Version: 1.0
In-Reply-To: <CAN-5tyGD3hNcG7=+xdB4Bs1OCCUoLzZ5ocsJusuxd3n3+x=7gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yes I don't understand what's going on with the network.  I can ssh to the server from the client over the 10G interfaces, login and get to a prompt.  I can even run some commands, but as soon as I try "top" then the session freezes, top works just fine if I ssh from my workstation to the server over the 10G interface, and top works fine if i ssh from the client to the server over the 1G interface..... maybe post on LinuxQuestions or something??

