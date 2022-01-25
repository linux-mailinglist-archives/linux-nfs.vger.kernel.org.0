Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC8B49BE39
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 23:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiAYWLZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 17:11:25 -0500
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:30907 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiAYWLY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 17:11:24 -0500
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 315845017
X-IPAS-Result: =?us-ascii?q?A2G+AQBzdPBhh6o4L2haHgEBCxIMQIMsKC6BVmqESoNIA?=
 =?us-ascii?q?QGFOYUOgwIDnXUDGDwCCQEBAQEBAQEBAQcCQQQBAQMEhH4Cg10mOBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBgEBAQEBAQUEAgIQAQEBAQsNDggLBg4VIoUvOQ2DU?=
 =?us-ascii?q?007AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBCD0BA?=
 =?us-ascii?q?QEBAgESERUIAQE3AQQLCw4KAgImAgIyJQYNBgIBARcHgmKCZgMNIQGhHgGBE?=
 =?us-ascii?q?wEWPgIjAUABAQuBCIkMeoExgQGCCAEBBgQEhQ0YRgkNgVsJCQGBBiqDDoslQ?=
 =?us-ascii?q?4FJRIE8D4J0PoN/DRARAoMugkMikWgGMl0BMBsvLEojSkWhDGCeAINPn0IGD?=
 =?us-ascii?q?wUup3mWR6Y7AgQCBAUCDgEBBoF4gX8zGggdE4MkURkPjiAZg1iKfSMyOAIGC?=
 =?us-ascii?q?wEBAwmNZQGCRQEB?=
IronPort-PHdr: A9a23:ICm5xx3p500maWt5smDPpVBlVkEcU/3cMg0U788hjLRDOuSm8o/5N
 UPSrfNqkBfSXIrd5v4F7oies63pVWEap5rUtncEfc9AUhYfgpAQmAotSMeOFUz8KqvsaCo3V
 MRPXVNo5Te1K09QTcP3e12Uv2G//TcJXBjzKFkdGw==
IronPort-Data: A9a23:tZ1cdKroCP0ET+Aem0aynMAZK9NeBmK9ZRIvgKrLsJaIsI4StFCzt
 garIBnTPK2MMWv0KI9waI+180xQuMXWmN9qGgQ6/CFkFX8R8uPIVI+TRqvS04N+DSFioGZPt
 Zh2hgzocZhcokcxIn5BC5C5xZVG/fjgqoHUVaiUakideSc+EH170Us5xrZj6mJVqYHR7z2l6
 IuaT/L3ZQfNNw5cagr4PIra9XuDFNyr0N8plgRWicJj5TcypFFJZH4rHpxdGlOjKmVi8k9Wc
 M6YpF2x1juxEx7AkbpJmJ6jGqEBaua60QRjFhO68kVt6/RPjnVa70o1CBYTQUIP0CyQoN178
 8puvIXsTFY2APLKud1IBnG0EwkmVUFH0JnuBCHm9Oe0lgjBeXaqxOhyBkYrO4Fe4vxwHWxF6
 f0fLnYKcwyHgOW1hrm8T4GAhOx6dJWtYNxZ5y8mlG6BZRolacmrr6Hi/dBf0SsirsVHAfaYe
 tYUeTN0KhnMfnWjP39MUc9uwLrw3yaXnztwlG/NiJtu3XLv1QFD6b/sM/T5Ud2yWpAA9qqfj
 jmfpD+mav0AD/SVxzuI9n63ruHOkCf3Q48JUrqi+ZZCi12OzW9VDBAIWEGTpuOwgUqzHdlYL
 iQ89iMvt6Ua+EqmQZ/2WBjQiHqFuAMMHtxeCMUk5wyXjKnZ+QCUAi4DVDEpVTA9nMo/RDhv3
 VjQmdrsXGVrqOfMFirb8aqIpzSvPyRTNXUFeSIPUQoC5Z/kvZ03iRXMCN1kFcZZk+EZBxn1m
 2uTtRczjY4MrscSi6Dq4m6YhROV882hohEO2i3bWWes7wVcbYGjZpC15VWz0RqmBNbGJrVml
 Chb8/Vy/NziHrnRy3LVG7ll8KWBoq/famaA2AIH84wJrmz1oxaekZZsDCaSzauF3zZtRNMES
 ErauAcU75gKOnKvNPZze9joVJxsyrX8H9P4UPySdsBJfpV6aA6A+mdpeFKU2Gfu1kMrlMnT2
 Kt3k+7zUR726ow+k1JaotvxN5d2nUjSIkuOH/jGI+yPi+b2WZJsYe5t3KGyRu449riYhw7e7
 sxSMcCHoz0GDrGlO3KKrdZLdgxRRZTeOXwQg5wHHgJkClo2cFzN99eKndvNhqQ5wvgEy7+Up
 hlRpGcBlgKm3CKvxfq2hoBLM+q0BskXQYMTOC0nJ1Gz3HY/KY2o9r8YbZIrfL4hnNGPPtYlJ
 8Tpj/6oW6wVIhyeo2R1RcCk8ORKKUr37SrTYXvNSGVuJ/ZIGl2Skve5L1uHycX7JnHq3SfIi
 +b8jVyzrFtqb1gKMfs6n9r2nwru5iBMwbwrN6YKS/EKEHjRHEFRA3SZppcKzwskcH0vGhPyO
 96qPCol
IronPort-HdrOrdr: A9a23:DkE9D6PDQfedl8BcT0H155DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jztSWatN/eYgBHpTnyAtjlfZq6z+8J3WBxB8bZYOCCggeVxe5ZnOjfKlHbalXDH6tmpN
 xdmstFeaPN5DpB7foSiTPQe7hA/DDEytHQuQ639QYTcegAUdAE0+4WMHf9LqQ7fnglOXJvf6
 Dsmvav6gDQMkg/X4CePD0oTuLDr9rEmNbPZgMHPQcu7E2rgSmz4LD3PhCE1lNGOgk/jIsKwC
 zgqUjU96+ju/a0xlv10HLS1Y1fnJ/ExsFYDMKBp8AJInHHixquZq5mR7qe1QpF6t2H2RIPqp
 3hsh0gN8N85zf4eXy0mwLk303a3DMn+xbZuCmlqEqmhfa8aCMxCsJHi44cWADe8VAcsNZ117
 8O936FtrJMZCmw3RjV1pztbVVHh0C0qX0tnao4lHpES7YTb7dXsMg24F5VKpEdByj3gbpXXt
 WGNPusp8q+TGnqLUww5gJUsZmRtzUIb1i7q3E5y4yoO2M8pgE886MarPZv6UvouqhNDKWs3N
 60QpiAoos+OvP+XZgNddvpfvHHeVAlYSi8eV56cm6XXJ3uBRr22uzKCfMOla2XUa1N8IY/iZ
 zaFHxCs2p3V1PJYPf+qaF2zg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,315,1635224400"; 
   d="scan'208";a="315845017"
X-Utexas-Seen-Outbound: true
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 16:11:24 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1gNuadO7raEuLswCmNsxV1FjD3BJrtkvnS1NyhbSPm+HJ95vbUUtepyLS5RhcmfI81gGYyQNAndQD5Lv/rmYW5GJDyMXC5inmy8wUcbx3jsISeOy9efPSzLvOBYzb45ifbBldjqYZ75JzXNNGwPEuRJeTkxhf0T0kC6tNZ261foKZDcDyrF29NakQ2Iqsdes8v8i/Zm8PluDM2J/aIdG7LlGF+t4LYG338Uq7xFQ34MBnLaSiMJd14AI+X7PyRqOudCwr8UdEulyTYRLeJVG2J5p62+H2DCw0USUbcrc7iCJsKK8FUeLMjBF8hh58GNjYSqKzIk1ZxyUTYfv8MwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huGnqYN28IBvE4ZEfdTuTdGZjl0QyK8xMcPSN0oqgKM=;
 b=KFJKHDbR1Xa//SINCdUvJa9CJZFcqA3JlhOKwMkUSAZLffjYER+qhMH9U5+M0oaJAeOPBdT0gtPJTaOC6CEBqAtZTpKwHyh2PSgVDF2whWqFRE0CyUw7Jepel5ey9e9Ra1w5ZIc3SaN2jWQGki9QXttTIbOGqzQg500riKS1cP3tmTvjTWEwIXFSVeZcmyI/IHlBgFL8+7YkEFHeYoYOZeOKTv2AU60IQ6FpYdqzf7sLAo2xXd57j1wcXNHUGMpGx781rI3gaX4Y4sZz8cJJAXPRVFrLk3v95QfR9tUfzTQjcSYkl11v9fW4gjEecSnU0deb89rjMxgM+4vF/RS5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huGnqYN28IBvE4ZEfdTuTdGZjl0QyK8xMcPSN0oqgKM=;
 b=ftoDqP6AGMpucoNWHLCMTtmUIRCdvTy9kMeAoOloirOxF2Tn4EPFKUBfIUXX7eCaefyIhshB6mV0UVbYe9Cr8PTBTPIso1ErbCaBL+80HTGcPFm+f2+Rl2naYl4MY2tEM6vVCtX55LByu1GetA84TxQWT9AVjNbK1RsvVPv08+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by SN6PR06MB4861.namprd06.prod.outlook.com (2603:10b6:805:c1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 22:11:21 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 22:11:21 +0000
Message-ID: <7256e781-5ab8-2b39-cb69-58a73ae48786@math.utexas.edu>
Date:   Tue, 25 Jan 2022 16:11:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: parallel file create rates (+high latency)
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Daire Byrne <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org>
 <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org>
 <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
 <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu>
 <20220125215942.GC17638@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
In-Reply-To: <20220125215942.GC17638@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:806:126::17) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94cf1bc6-205d-48dc-288e-08d9e04f9e2f
X-MS-TrafficTypeDiagnostic: SN6PR06MB4861:EE_
X-Microsoft-Antispam-PRVS: <SN6PR06MB4861F7CD54A190C9873159EA835F9@SN6PR06MB4861.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BL0S7X/WuSxTeI7uzUkKnNTAo8/VmN4DLms8YuD5et5zxGPevvVUM9oBlVwD5E8HQ0vr1INO/KcynWufKyjHsJhyyGWQ9jbtj/PfR+YoHBrOgQEckNcGfDI3ZQ5JZ9ts01koyBPaBAq0aDFTgXJskenOTXxASl9CRaptiPY5F80fNy7BuHFQfFEywu+YAqtShfKx/e8oyKeOF5NlZL7ZJP07nlRsp26nEoAaskdQSYxWjpXLbprmg4+jfjS0Lz/oANVNM6MNwwfY6cT9cAHyyNV6XHOdZeBacswqDUEt/DpKAJM1G8jWRRLW0yg2QYV/chnYYuJc56YtYI+0UkLyFTFWXqf0TLUlk6i4fZfSIHTFQ5qjVymmRN/aJjMh0VNfjJ+QqEk3lelIpvJ4h9u07NEaPS3VLkqkIejDFNCEXnRzOSdoEe8+h1zlqREJnZDcIofB9G6/n7aEURayCPWzBMAGGZq7d9UJAgoDouEuPVHRb/iXQ2sjFhQKZld4aG2JEN9/J4K3s9KptwqKzFbTLh/RG4gfIMYQVkzFrEoJlYzyK2Hb/Z7HWl05SR4iNaH67TMqVyLJ1SbIHb7DXqtlUn9ZlnAHPNklmuNezb0qDzRna+5ky5vGDDSDVVoWvSXbRfyBOfEhcB8tY8+PSRAVxgZcaoCNJxEHLyDYQ04t46m06fmRwpuRIAGvmLFTC8XIcMJhNreOZJH3ES6jbThi+FH3VbriGrxGKGXHw4cazWhbS+CUP1kw4fXDd0PIviHyYYe+d1rQC7TLzwxSu8Y3eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(53546011)(26005)(6506007)(86362001)(54906003)(4326008)(8936002)(2616005)(6512007)(38100700002)(31686004)(52116002)(8676002)(38350700002)(66476007)(186003)(6666004)(316002)(786003)(6486002)(75432002)(83380400001)(66946007)(5660300002)(2906002)(66556008)(31696002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdoZGVzQTloVkFRNHJTN0txV3p1bjVRSG5rM1NYMUZWK0JMRXNRaUM5STRt?=
 =?utf-8?B?SmhCOEtRMnlvby9CMlVBNy9naFdZWmZTSXNRVFo4VWpVUTh6MXlDYytVZERR?=
 =?utf-8?B?eDA2UHBXYWdVNDlqRVFOTG5pa0RmYWRkVVlGSklhTVlRUUFNV2F2aHJobElH?=
 =?utf-8?B?NUltcDkwSXZkYWdVdWtrSVhUcDlNMnZPZnAyaGUvSkhwWkxkVk1KalVNZitX?=
 =?utf-8?B?QUZ2YUY4SVhnUEgyVDJpTU9scnA4RGtFUEp4eHF0UlNobEo5K0FpWkJmS1Fz?=
 =?utf-8?B?NHJ4eVIySTlTUXNrMlJ4bkZqMXJtMm9kODRQUXRyN21iOElzZTBqaGw1UlRr?=
 =?utf-8?B?T0JxL1Q5Qkp4TC9FRE9oMFBZNE9RckZxcUM4R0duVTZmUWdDMEhyQ21sSVkz?=
 =?utf-8?B?cTdHbVY5WEx0NVdjbUpRM0N5NnZKd2NuOWJuRC9TTVdGYVB6Wm1HOVg2a2s5?=
 =?utf-8?B?MXd6bXlSQlJNNnpiZVRUT3lSRGNsaThMT1o5TTlxVlpaMVRFRzQ0QjRqQ2ZI?=
 =?utf-8?B?dUYyU3o4VmlPWHBmeXQ0RGlvODN4K28xYkFYRGcvT3N5ekZCMFVIRnFkNHl1?=
 =?utf-8?B?ZjM0b25TRTJuR3F6Mkk5QUFJSVZjSkVJU3VPMzMwOUZDQnhseEltV1g1TktW?=
 =?utf-8?B?ZGNzcjJDUXR5RzZKWThZY0FFdG5WWjRwc1MzUWRYdnluSUw2YkROb1kwb2JQ?=
 =?utf-8?B?bE1YeDlnOVJxbXZOVEg1SXhuaVFNS25FNkZuVzJZdktOaGJMVnNFSjY2eUE5?=
 =?utf-8?B?bUlkMUVnOTdZNkFHZjNZWXZhTUxRUEpORkFOaDFkL0tsU1h4em52bW9aMXJW?=
 =?utf-8?B?anoxUWRYcm0rYTFBYTk0anpxeU5nL25lMXdwOWhIYjViQ2dxTGlYZ1NlVHp5?=
 =?utf-8?B?cFNvZG0rbVk2TEM2N2FWWldtUldXMVFQWVF1TmgwSUthMllEMmV5amhiVVpZ?=
 =?utf-8?B?cDF4NkJ2eVo5N1FZQnJ3QnhyakJrdCtSaDlpTld3UVB6VjVoM3dUQVBlYTlk?=
 =?utf-8?B?UEIwMFA3Z3JrYllLSkZhdE0wWXpaS1Q1am1zWDhMSFh5MDlVV2NVWlBuZUNL?=
 =?utf-8?B?dVArckkyaHVVYkFWRFhBR2tWYlNvcDRwL3l4aHo2elFwaFdlcWluZWNOUXBr?=
 =?utf-8?B?djhEVWFma2RyMTk1TXk2cUZzM0pMakc1UDVGMTByOVNGcEVvUzkxbzlJYTUw?=
 =?utf-8?B?cEswK2VIVmtKYzQyb2FvUnIweWQ5b0JkQnV0c0VTdkJoeFFsN1cxMmg2ZWZK?=
 =?utf-8?B?TjhDMFU0cVF2SlM1c3BvUnhkK1Y0R21LU3p1U0Y4V0tQRFRMeFFYUitpY3BY?=
 =?utf-8?B?UFVjUmZTcGQ0WVBhbkc0a1BWZkp2SFIxQkdZUUV1T2NwL05sQjBNZ0N4NFh0?=
 =?utf-8?B?UFc2T25abGxsa0J2aExzQWdpSGVoVW5ET3VOc2JUbmllWTZyV1NkRklhUnJJ?=
 =?utf-8?B?azBpWTRxd1cxMjVwUHhLL2FZMFAweUZQSXZlRDcwRmhJdE45R1Y4ZWVZcE1N?=
 =?utf-8?B?d0o5b3RleXAzRlI4T0pobEt1RHZGTk1MOC85NFFnWndRbDZBUEZQMTFhM2cv?=
 =?utf-8?B?NzRsTFA5M011UnZRWTFKQnpjcEZDQ3hLcis1b2tHWkQ0ajZJc2RNdFpZRUI2?=
 =?utf-8?B?TGpDeklSL3BvQVcxcDVlQmpGU1JXenRSeWw1OHcvdzlOSllxTE55NlovQTRC?=
 =?utf-8?B?STVIeWwzNnRkVTdKSTNLOXNxUUF6NXppeG43QjM5VUlsemMwOERlZXIvandh?=
 =?utf-8?B?bmY2aTdqY1NONllvcDBJTjZzVkZlWXJIZW1ybnk2SHJGQ0pFMXBwMDRKQW5w?=
 =?utf-8?B?a0NZejY2SVhsZk9iS0JFenk0MlZZd2ZkSTlSRlVTSW9RdUtWQ2NXenNzaG5s?=
 =?utf-8?B?ci9CZEZ1TVBDb3NYd3d5ekdKQitQTnlJeHIrUk83by85QnNhNUFLaTF6Rmlx?=
 =?utf-8?B?MEVKMWN3ajNWdFRCYSs1ME55aE5ydjVsaDg5SlREVjl1YzBWWks3SGZHeXBq?=
 =?utf-8?B?WWt1dzZONFlEaFdmb3hKM0tWZmJ0am85VTdBTUVwTXBpa0dJbFJpZm8wcUtm?=
 =?utf-8?B?N0VnZlBCQVFlNmFBdDFUTVl4NktQekpWVm9OWlNjUkNZTTJJVG0rNEFQVkhn?=
 =?utf-8?B?cDZBZnFGaytlUkRNV1BNWTEwZ1FGV1hhbWdodmhxRGR4bWFyTlZ5N1hRbk1E?=
 =?utf-8?Q?Ngus1JA+N6V/GzQuxozzcpo=3D?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cf1bc6-205d-48dc-288e-08d9e04f9e2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 22:11:21.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKQ8zAn0bwkJXQQel+ocCHK7gPTujmudYpjlzz2AjuijKIBLkCa4zvQvx7MYup2/wL0cXSNmp/XD807dORqlAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR06MB4861
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/25/22 15:59, Bruce Fields wrote:
> On Tue, Jan 25, 2022 at 03:50:05PM -0600, Patrick Goetz wrote:
>> On 1/25/22 09:30, Chuck Lever III wrote:
>>>> On Jan 25, 2022, at 8:59 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>>> On Tue, Jan 25, 2022 at 12:52:46PM +0000, Daire Byrne wrote:
>>>>> Yea, it does seem like the server is the ultimate arbitrar and the
>>>>> fact that multiple clients can achieve much higher rates of
>>>>> parallelism does suggest that the VFS locking per client is somewhat
>>>>> redundant and limiting (in this super niche case).
>>>>
>>>> It doesn't seem *so* weird to have a server with fast storage a long
>>>> round-trip time away, in which case the client-side operation could take
>>>> several orders of magnitude longer than the server.
>>>>
>>>> Though even if the client locking wasn't a factor, you might still have
>>>> to do some work to take advantage of that.  (E.g. if your workload is
>>>> just a single "untar"--it still waits for one create before doing the
>>>> next one).
>>>
>>> Note that this is also an issue for data center area filesystems, where
>>> back-end replication of metadata updates makes creates and deletes as
>>> slow as if they were being done on storage hundreds of miles away.
>>>
>>> The solution of choice appears to be to replace tar/rsync and such
>>> tools with versions that are smarter about parallelizing file creation
>>> and deletion.
>>
>> Are these tools available to mere mortals?  If so, what are they
>> called.  This is a problem I'm currently dealing with; trying to
>> back up hundreds of terabytes of image data.
> 
> How many files, though?
> 

IDK, 4000 images per collection, with hundreds of collections on disk? 
Say at least 500,000 files?  Maybe a million? With most files about 1GB 
in size.  I was trying to just rsync it all from the data server to a 
ZFS-based backup server in our data center, but the backup started 
failing constantly because the filesystem would change after rsync had 
already constructed an index. Even after an initial copy, a backup like 
that runs for over a week.  The strategy I'm about to try and implement 
is to NFS mount the data server's data partition to the backup server 
and then have a script walk through the directory hierarchy, rsyncing 
collections one at a time.  ZFS send/receive would probably be better, 
but the data server isn't configured with ZFS.



> Writes of file data *should* be limited mainly just be your network and
> disk bandwidth.
> 
> Creation of files is limited by network and disk latency, is more
> complicated, and is where multiple processes are more likely to help.
> 
> --b.
