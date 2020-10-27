Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7429C962
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503945AbgJ0UDz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 16:03:55 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:55847 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411101AbgJ0UDy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Oct 2020 16:03:54 -0400
IronPort-SDR: fwaahcm9wehQMqnLROd/M6VNIdrSjaNoJqfKPuWah7+DeIB7/wQLakY/+olnVnaf+cL4NAyVxz
 eChVC/eWmCcqOIZexiTRdX4IHpaItBmwJ/nd4IyQp40WEdgAmd9Ib8K8yINlSXk0saK2RFDoo8
 coTeVuS1acCXY5uqGstzH0DenbeoYhhYx1eFkcyihr2c/qSBni/t8IRhO5mzwbL2AeF0NHpObI
 iENdvT51vPhGUGTex8Av9WUupwpvJHs7vvJ45n2xeysZd+vatkCzpKKBrEnLlXDfl9Pz/5LRs0
 OzA=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 248760297
X-IPAS-Result: =?us-ascii?q?A2ECAQB4fJhfh6k5L2hgHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+BUlGCLAqEM4NKAQGFOYdfCCaYeoJTAxg9AgkBAQEBAQEBAQEHAi0CBAEBA?=
 =?us-ascii?q?oRIAjWBUiY4EwIDAQEBAwIDAQEBAQYBAQEBAQEFBAICEAEBAYV+OQyDVE06A?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBDD0BAQEBA?=
 =?us-ascii?q?gESERUIAQE3AQ8LGAICJgICMiUGAQwIAQEegwSCTAMOIAGaSQGBKD4CIwE/A?=
 =?us-ascii?q?QELgQcpiGh2gTKDBAEBBYJMglEYQQkNgTkJCQGBBCqCcopigUE/gTgMA4IsL?=
 =?us-ascii?q?j6EJYMvgl+QKIwBVIETmXqCdZpwBQcDH5JEjxqTP6A5AgQCBAUCDgEBBYFrg?=
 =?us-ascii?q?XszGggdE4MkUBcCDY4fGoNXinZWOAIGCgEBAwl8jDsBgRABAQ?=
IronPort-PHdr: =?us-ascii?q?9a23=3APD4ELxyPBUr+vdrXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5ZReDt+tigUWPXojB7f9Aze3MvPOoVW8B5MOHt3YPONxJWg?=
 =?us-ascii?q?QegMob1wonHIaeCEL9IfKrCk5yHMlLWFJ/uX3uN09TFZXgaFDI5H6/9zgfHl?=
 =?us-ascii?q?P4LwUmbujwE5TZ2sKw0e368pbPYgJO0Ty6Z74XTl22oAzdu9NQj5FlL/M0ww?=
 =?us-ascii?q?fJ5GZUdvRf3iVlKU/Akg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,424,1596517200"; 
   d="scan'208";a="248760297"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 15:03:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6FHXzRVPg3n8CH2SiZgj5X9vqsw9GL5xnAl1p9yGQHqOubwgruvQ3tN4fNP7juEoap46wMNUBzBGtV3rBU/4JsYhV2GiSjP4DSf1coYrsvxjvlMQfQ9HPxASfXKzGdIwC24cS5qXCw48SjaTHV4pEDBXt7ElD5SQscb1EXyXDtk8yGigF1Hikpd9lEONfzBl+qKtrodJe0lHJCNbFbWWCYJwAvnXPI9h2d6AFZvvx620Vhan93LJl/hGxUIOYnmnw8HkqOTjBBFWsbC5i/OPT6FE+toU4dem25pHWSjwby8In6kx8aFVVqTmKcl8QKVygRR7D0kTWBXu8pmnfRdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg5UseH/rL/UtT6KGhMYvC5nCebbQ4rl6boApptVuZg=;
 b=guRjFuH7OyY4JV0BOrM/5olA7LSj/umrf5Fj7ytOrq5jHClMWmXIr/z2lqzoWXlAkM6DVyEjh9sRLPrsjfH1DrH9cvQ3eDt7h6RsXUmwKXDAo/oU7Vys1aTCv+lgZLaFGFO/jeCPvKp7frPoTxSMjNmwmgeVzmfOqDAC2KBoFuRfk5rjdOYV3CQSWWIWV/E+f4EPZKd21Qm18eHAPJcsRKsU9gQh2v4xU/VG/V0SzlNgIQaXg4MMnqQ8nm3qqG+N44Y/Bk4YXocXZk47FqEdspqNYa2A4FtCXHrQxo7DCRMZsvAK+dgzxUiHBWSRQt74tlZpcI4a8sRtcr/p8QJ3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg5UseH/rL/UtT6KGhMYvC5nCebbQ4rl6boApptVuZg=;
 b=AKnBraBuvmDLAx1HmRYC3K8kKSfg4aWOCHxo81zrLYePjBiTYV4/RbH5SvW2CwH4Ozslo2nalUwHcG8969O590rFyp5ekY8tnIWCCOiN78tcVKdlX69TOSm4WuWJz+mgAhfXBimZRpgQ3K9xXD6rpGsu8gCKQa18zjsB8dpPJC4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BY5PR06MB6530.namprd06.prod.outlook.com (2603:10b6:a03:232::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 20:03:52 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::5863:bd59:1661:becf]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::5863:bd59:1661:becf%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:03:52 +0000
Subject: Re: Hard linking symlink does not work
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <CAGj4m+5rpNqW=XnU2cxGmWiBi47w3XTvn9EGekVPjq74pHfFGA@mail.gmail.com>
 <20201027171240.GA1644@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <5dddc4b5-7777-859e-2730-28afc3067c57@math.utexas.edu>
Date:   Tue, 27 Oct 2020 15:03:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201027171240.GA1644@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN4PR0401CA0047.namprd04.prod.outlook.com
 (2603:10b6:803:2a::33) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by SN4PR0401CA0047.namprd04.prod.outlook.com (2603:10b6:803:2a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:03:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c695cf3-bf00-4c94-a90f-08d87ab36cec
X-MS-TrafficTypeDiagnostic: BY5PR06MB6530:
X-Microsoft-Antispam-PRVS: <BY5PR06MB65300537689E1B778472D6F183160@BY5PR06MB6530.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OPvEhAjrJowa8O6X9ZcAzJK7vuV+sHTSNn5bRVYA5+xDpPsobN9PXEPBD8SVQ0GhVVuiY8/WyNPzjYVCJAKE3LZe1KjhMjYD6WKHaHt/wy5SnaIb/efU6gUA0aHRf5DlQ3HmcdYo6qW+zIAyLqA7HCgIE5c7V3xScl9Qkrl4cBaXFqVmt1yOaaXZZAwjT49pEhfHB00IX2V1ByIXMQooRHJFoTYO1Rg/PhKceOnsZXB4RpQ1OBX/SfX7pYDEpmveJ5iMEHC/SIJ2xgBxIwU9pHguGidpdJ2GXeYNxfW3TecCumqoy8u+g0x2394ELhw0lMhKdaX/mzcPSIsA95Vc6jgEkSG5zwYELj3e/Gzq5UOm4Khqz5XMQnrTvgFGCca
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(786003)(31696002)(478600001)(2906002)(8676002)(75432002)(956004)(2616005)(8936002)(6486002)(110136005)(4326008)(316002)(186003)(16526019)(86362001)(66946007)(53546011)(5660300002)(52116002)(31686004)(66556008)(83380400001)(16576012)(66476007)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /lPeVdGZsGrJSqwKNC5NEFhIEr9s+DgXlWvSkmskXcPk3aZ4K5/jnnvIpBzRSh6bUgesM4PR31eWuCwuxsLgo75y0TCvfOvNOl2bVxWZGBQbZGxjRb1xw1kp0RWzEhJPUWh8OQwwDbh+MaZHVWODR9htItgWkixEugzrducrCbR5YdgeP19uK4s3VROOyjYhIV9EimUcYKn7XpTPu69j+WFA8XReuXjqV0c9EE47hzDgToYa/QDS6+DViyN/nI37Kp9ANfP1C/H00i45SOPx9mAsM25Ldyh7qfQaEUfau5iObjB4O7mziScg0Mql5Pk4f2Bt9kaXpOStYKAi3jjpokNJIIqaNRACF2H1lYKzd7vZIo7I48JOAUXSLWqjR6t5ZeZKqEjcgk9WvSlFQ19LQwudaTWooNx0gqxALl+Zd4tDLJYPxLOo8gqaIrCJrkibEwTPs/3igqdeTLDS5T3LzU5CzdALFSicgsd1nHEOCxY/Hy2lkYJcevjAe4kjzu5P1siq3b7hGhaaWXE5E+gM0oJuwFXZtfSPxLzgQQu5r3Tkzvj32u7RJxX6MfNvw6uyPT5nOx6uL9V621pF2fKV7Ee672hyGjdns+wyjsS9t80gDWuuWSv9eLNPhu9ajAPUHIOp1PB6PlNoFJuwz7XF9Q==
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c695cf3-bf00-4c94-a90f-08d87ab36cec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:03:51.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ02qVwVC8j7w58nu7TWB8RWKVoPsZ3eNtKhXWtstwKUkU/maJVvn3LdR3zZykRQ/uwH6miXWigLwayO34B7kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6530
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/27/20 12:12 PM, J. Bruce Fields wrote:
> On Fri, Oct 23, 2020 at 01:13:02PM +0300, Vasyl Vavrychuk wrote:
>> I have found that hard links for regular files works well for me over NFS:
>>
>> $ touch bar
>> $ ln bar tata
>>
>> But if I try to make hard link for symlink, then it fails:
>>
>> $ ln -s foo bar
>> $ ln bar tata
>> ln: failed to create hard link 'tata' => 'bar': Operation not permitted
> 
> Huh.  I'm not sure I even realized it was possible to hardlink symlinks.
> Makes sense, I guess.

What's even the use case for hard linking a symlink?  That sounds like 
asking for trouble...


> 
> I think my first step debugging this would be to watch wireshark while
> attempting the "ln", and see what happens.  That should tell us whether
> it's the client or server that's failing the operation.
> 
> --b.
> 
>>
>> I am using NFSv4 with Vagrant, here is mount entry:
>>
>> 172.28.128.1:PATH on /vagrant type nfs4
>> (rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=IP,local_lock=none,addr=IP)
>>
>> I have also verified that rpc-statd is running on host.
>>
>> Host machine is Ubuntu 18.04 with NFS packages version 1:1.3.4-2.1ubuntu5.3.
>>
>> Will appreciate help on this.
>>
>> Thanks,
>> Vasyl
