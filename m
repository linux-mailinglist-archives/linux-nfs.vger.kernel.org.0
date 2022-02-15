Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5834B7A4C
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 23:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiBOWOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 17:14:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241830AbiBOWOo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 17:14:44 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 14:14:33 PST
Received: from esa12.utexas.iphmx.com (esa12.utexas.iphmx.com [216.71.154.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D927CC8
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 14:14:33 -0800 (PST)
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 325765340
X-IPAS-Result: =?us-ascii?q?A2GTDgCpJAxih2Y6L2haHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VwBgTkCAQEBAQEPVoFWe4RVg0sBAYU5hQ+CVC6eAQMYPAIJAQEBAQEBAQEBB?=
 =?us-ascii?q?wISExwEAQEDBIkHJjgTAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBAQEFBAICE?=
 =?us-ascii?q?AEBAQELDQkFCAoHDhAFIoUvOQEMQAEQAYMBTTsBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEFAoEIVhEEEQgBASMVNAImAjQrDQgBAR6CY?=
 =?us-ascii?q?oJmAy4BnkoBgRMBFj4CIwFAAQELgQiKBn8ygQGCCAEBBgQEglOCNxhGCQ2BW?=
 =?us-ascii?q?wkJAYEGKgIBAQEBAQEBgweHIoRWgUlEgRUnD4JEgXMBgxYRAoMugmWWCSwlP?=
 =?us-ascii?q?l2SSi+OXmCeB4NRBZIQjTcGDwUug3KSf5EfgyqGTYxTIKYpAgQCBAUCDgEBB?=
 =?us-ascii?q?oF4gX8zGggdE4MkURkPjiwLAgmDT4p9IzM4AgYLAQEDCYw3giEBgkUBAQ?=
IronPort-PHdr: A9a23:Hw95iBKsqdMxqL9eP9mcuWsyDhhOgF28FgIW659yjbVIf+zj+pn5J
 0XQ6L1ri0OBRoTU7f9Iyo+0+6DtUGAN+9CN5XYFdpEfWxoMk85DmQsmDYaMAlH6K/i/aSs8E
 YxCWVZp8mv9P1JSHZP7bkHS5GCu4C4bAVPyORcmTtk=
IronPort-Data: A9a23:R+a7q6MvoTdxCF/vrR1Wl8FynXyQoLVcMsEvi/4bfWQNrUpz3mYFy
 mAbXWyOPfeLMWXzKo92YdnipxwC7Z7VmtA1GXM5pCpnJ55oRWopJjg4wmPYZX76whjrERoPA
 /3z7rAsFehsJpPmjk7F3oPJ8D8shclkepKmULSeYnooGFc/IMscoUsLd9AR09YAbeeRXlvlV
 ePa+6Uz73f8hlaYmkpNg06ygEsHUMba4Vv0jXRiDRx/h2IyolFOZH4pyQBdGFOjKmVcNrbSq
 +8uV9hV9EuBl/smIovNfroW7iTm61MdVOSDoiM+ZkSsvvRNjgEw3YobCPkgVQBari2suddX7
 O9hhZPlHG/FPoWU8Agcez9xNngmeIFjpvrAK3X5ttGPxUrbdXeq2+9pEEw9IYwf/KBwHH1K8
 vsbbjsKa3hvhcrvmO79FrYq25RldZGxVG8ckigIITXxFfkhTIzRa6DD+d8ewSs9lslVW/vSe
 qL1bBI0NkmfPUAUZg9/5JQWgcOIvyKhUBli+EuqvbE240Ph/jF9z+24WDbSUofTHp4K9qqCn
 UrC/mLkElQcOse31zWI6DSvi/XJkCe9X5gdfIBU7dZviVyXg2AWVhsfUALjpeHj0xbkHdVCN
 0YT5ywi67Ao81CmRcX8WBv+p2OYuhkbWJxbFOhSBByxJrT8zgSWKkg4TQJ9L9EDrOoQQhoO7
 HO5kIa8bdBwi4G9RXWY/7aSiDq9PykJMGMPDRM5oRs5D8rL/Nht1kiWJjp3OOvk1YOsQ2qYL
 yWi9XBm390uYdg3O7JXFLwtqx6hvdDsSQ8z6x6/somNs1siPNHNi2BF+THmARtoKY+YShyNu
 SYCks3HtOQWV8jVzmqKXfkHG6yv67CdKjrAjFVzHp4nsTOw53qkeoMW6zZ7TKuIDirmUWC5C
 KMwkVoOjHO2AJdMRfMnC25WI5lxpZUM7fy/CpjpgiNmO/CdjjOv8iB0flK31GvwikUqmqxXE
 c7FLZrzXStEVf43nWPeqwIhPVkDln5WKYT7FcCT8vhb+ebEDJJoYetYbArTNrxhhE96iFyEr
 YgCb6NmNCmzoMWlO3KMrub/3HgPLHMhAovxpdAffemZOg18EX0gDPm5/F/SU90Nokihrc+Rp
 ivVchYAljLX3CSbQS3XNCwLQO6xDP5X8CNjVQRxbA3A8yVyMe6HsvxFH7NpJuZPyQCW5aUpJ
 xXzU57cWasnp/Wu02h1UKQRW6Q7L0r13FrXZXL6CNX9FrY5LzH0FhbfVlOH3EEz4uCf76PSf
 5XIOtvnfKc+
IronPort-HdrOrdr: A9a23:tTfhoairPF/XvZKOxH/8nPSoOHBQX0R13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03I+eruBEDyewK4yXcT2/hoAV7CZniehILMFu1fBOTZsl7d8kHFh4lgPM
 RbAtVD4b/LbWSS5PySiGfYLz9J+qj8zEnCv5a5854Cd3APV0gt1XYaNu7NeXcGPzWuSKBJYq
 a0145inX6NaH4XZsO0Cj0sWPXCncTCkNbDbQQdDxAqxQGShXfwgYSKWySw71M7aXdi0L0i+W
 /Kn0jQ4biiieiyzlv523XI55pbtdP9wp9oBdCKiOISNjLw4zzYLbhJavmnhnQYseuv4FElnJ
 3lpAohBd167zfrcmS8sXLWqnzd+Qdrz0Wn5U6TgHPlr8C8bik9EdB9iYVQdQacw1Y8vflnuZ
 g7k16xht5yN1ftjS7979/HW1VBjUyvu0cvluYVkjh2TZYeUrlMtoYSlXklXavoJBiKprzPLd
 MeTf01vJ1tABOnhjHizyNSKeWXLzsO9kzseDlAhiSXuwIm7kyRgXFohvD3pU1wi67VfaM0lN
 gsAp4Y6I2mcfVmE56VJN1xNfdfWVa9Ni4lDgqpUCXa/ec8Sjnwgq+y3Kg49emxPLMSyp93tI
 XmOWkoxVIPRw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,371,1635224400"; 
   d="scan'208";a="325765340"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 16:13:30 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5O4vudJL5rv0kR8j15D93gfy2Pvu2Zz7bXqgs5dGxEeCM7okgTNWLj0eD5brHEVfhbhdk4i4M9RKHu5ycCUCTxsuI7ImuPWugyTitUOihjspbzC56vm6pYfK3Ce2aBLXIVR5EOApAmkEYnXeVZMGgI7ihxvYRMrDCAnhPSIktMLc28vWMmngxcYAWt+pOyOV0bGiUkHwwzw9aBGtEnucab6xzrJ06lqySflXDmmtZI5PiodgLuvqBaRyhi20BYng7Q5PUmD8r/0KbQHXMP7NgixQReUNoqX8yzbbaIqfvei7PFmS2pG9ERadV6TwKOy1+YibgcnSGxRsd8vkfFGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VW3gS74hYleZQw2FPEzqOPhbgB+t6FifApWnGDlUq4=;
 b=j7KQrnv84PdjyQb4FVKpGJhnEJvO0stA0LnLlWU/iqbINypWS9vFvE8rt9kI2Ft2KgtkXR5P39aQDJyOA0QjN2p4gWhL3ZXQv5OZmDL/mqKuHBVG/BCninaNRZphZsPmpyte1jZyP3aiZtg59tzdmpn1InSdCXJzks6hi4v9Y7DCREnq9rTxeZZaNexzTQI5fsPQO3hhdxTfJqM2UM30HOAcNkSE7/6m6QNgoaAKgqdwdikensFDIQkfLPoI8Yx7gYOzzXwCTbxC8KNQxfdHsPGrjZCGAU+a1dymcb/pqAoZpgi/F2iz52eabT2w+kY2Vzi8JjxhM5zTOlE/3H2cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VW3gS74hYleZQw2FPEzqOPhbgB+t6FifApWnGDlUq4=;
 b=Nmd0+FqtB2ZFHY/wUvt9CmskwPzUtEMeXtipBNRmmtCLXRBj61iqWL3jS6HbDdJbEBWNcWzSPwCNwzQLrkJ/0etzA8KOMDCDl87lOwjtghLFBikhAMJ9F4+2N7U99QpiQGMK/uj9nnGOmu6KvNk1pg6KMCvP5xHn5OtIzYE9+TY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by MW4PR06MB8947.namprd06.prod.outlook.com (2603:10b6:303:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 22:13:27 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 22:13:27 +0000
Message-ID: <19e14932-ed88-60a1-844a-0e17deee269d@math.utexas.edu>
Date:   Tue, 15 Feb 2022 16:13:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Subject: How are client requests load balanced across multiple nfsd processes?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:806:121::20) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12fe226-b354-4257-1b75-08d9f0d0643f
X-MS-TrafficTypeDiagnostic: MW4PR06MB8947:EE_
X-Microsoft-Antispam-PRVS: <MW4PR06MB8947E809487AE9C053DD444583349@MW4PR06MB8947.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzMZp+nbsaOd2ItLCPhBx17GjMjdGft2Z7QtTcoBdhV1/VwMuvvZeIH2gzD0sJlRhHYJ6WRakgwUUytXqMsriskGqXYYtp7ufBYjpLXC9Vw+MQKHUdretR+gMdXBbk1Dv8FPYjEi3cOFK43D3d3+Zzcv6DoSl41GRY3Zc8k1YWQa70tumZm/94rlLlWy2CGNdPDENo+bo0jEY2QsN2tiLA9PQAVkknpPZwgzDUXwuJRk0KE+Eu744PpIxTm86P05uwJSKH8w+ka1/oobdQnxEBZet27g5MMv+31KHfoUjT4gUA7xuvDm/kcC7zK3Ys7jQvQ3uTrmmjqKzHYn02Pm+J6eonPhLlMaFCh/4PCFeUB/fFWdZiu6xV1mIKa7uuL7j6pt5PJAVAAdF9KzHpk7e5gkrHPuY88Ynf83PyDZrA8tLkMmKDje7SJgP7dJ7aB1wOeoL16d4udxd4PIoOwueXMd6iDwYuTiFiDj3YRPx4VE6F+dL/XbaR/+XQ5n2MS2MSgjT8l+Dfx2LqohskdqFs7JUNAUKnRTfxuLrpjtlhGuSPPR1eDqtaE+mFZONjoh6INFODUPsx6Uj0N31XLE4JmXyjkktteETffAAPgp3n7TzK9nOl+uI/37VUXAiRmHty9SntP0VXZK7c24qwu15PAwVb3MFuW1i7XyPyV62sOaNMUxmPTEiZoitkkAahNZX8zGAbEVL9Q6AGWTIkEFnIMs5x6tP9s2NAvtP4L8k6GTrWUhEOpFJiPUy0827uY/H+svZk+nBtZkYihahpaMZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(5660300002)(8676002)(786003)(66946007)(6916009)(66556008)(66476007)(26005)(83380400001)(31696002)(31686004)(186003)(2616005)(75432002)(86362001)(52116002)(6506007)(6512007)(2906002)(6486002)(508600001)(38350700002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtiSEdhK3dXRHVidEJFakFiVGU4NUIzYUtmSmk0WFoyNTJCaml5Tmc1MmVO?=
 =?utf-8?B?dWtyUWxoMXAwUVIyMFhlNlR1bytkRWVnQ1BTMWN4YUJtbWNUR0V1dFhyRTVC?=
 =?utf-8?B?bDMxd2Rob3JpdktPd0pFOHZjeVl1N2xSb1oyNSttaENISWtKanBBQVQvTGZU?=
 =?utf-8?B?U2d2anVHemx3NFd0bW1LbWRibjN3YitCTS9YUTdDOElzOHh0cHM1dTl6OExJ?=
 =?utf-8?B?c1ZUWmFtRk5tTVRwMXh2YnlOeU8wbkZtSkFLYTkyaThtUHJ0RGdGZzR3b3Jr?=
 =?utf-8?B?OVFjVG9lQ3Y5dVhmdnNpb2pKOXhqNTNzaGpPYUVFZWs5eXByTWp6RU1aQWN1?=
 =?utf-8?B?U0hKbGFUUWNDQWlidjhpZ016SWtHWHdnTVBiOWlJZW56WjdRQll0VktHUVhh?=
 =?utf-8?B?bTlzSHJkWjBPUGZRdEYzUnZjUk9kZ3lXNXlSVGFVRDN3ZlI5OUVnb01YU3h2?=
 =?utf-8?B?aFd6aHU0aVR5R2VJWDJTQ0xwRW5tSU5ETkpEL1NUWmNyNW9XVzFiL3VWQllN?=
 =?utf-8?B?SUMrNCtyMEFodEMrVDFsbUZIaWxvSW5Ba2h6NzNFa0d6WEVjcU1IM09Td3Za?=
 =?utf-8?B?d2oxT0lHWEt6a3lPMVBNRlBvRmtCbkNiZUdaNGtLUy9DN29JdzBnT0dKUGpz?=
 =?utf-8?B?eHRwaEFoNTdWVEJINjZUMGcwU3BHVU52eTZsR0hqTmNrN2dZY3ZuU2Q5aFJO?=
 =?utf-8?B?dzNSVmNsWGVHYVFIWjBQUHlpZDliRGhhbTViL2ZGbzVmRDJSbGRvWFZoMUh0?=
 =?utf-8?B?RUROaHpaanVSZjcxTXhhREMxZEdMVFp2TlhnNC9FMnVWZDV6WXlZSGNsblc5?=
 =?utf-8?B?L0xMOXJBRjVkdDVJc3J1TmowNXhyYnZzMk9IcjQ4TlpSWTdra243VWZyQVhu?=
 =?utf-8?B?YnB4SVUrU1MyQXQrc1Q4dStPT2hROE1UU1A5bDlnRndYRkRDTnJLVkk0blpm?=
 =?utf-8?B?TlN1NndsYlRPYnJtU3R0eE5pSkhnREk2WFBpNkVXdGx6bnMwVTVqakVhOUdQ?=
 =?utf-8?B?bzFRa2wxOXV1T0dZQ0Y1THY1N3dCVkhNdC9pQmkxc2VKK25XWW11dnJIbDNw?=
 =?utf-8?B?SkVldDZSUWZRNjV2a25qSDc0d3hFdWVpRFJyRGxBeVgzc2R6Ri8vV3VIVGht?=
 =?utf-8?B?SElERURMZlErdTl2L012MTJ0Rmd6VGpDclpKeUFRdEVVNlpBS0tmWkJLVWdZ?=
 =?utf-8?B?U0RGMVpSd29OcldvMjRBa2k5d0NDd2N6eXFPTEZjalo3dkFTck1pQkJuMUd5?=
 =?utf-8?B?c1NZMmNrZWg0T3J6NDdJaWdYa3lIeEVqMTBRMTBpdFZtQ3pwN1lIOUZld0x1?=
 =?utf-8?B?cEZFa2FPZ0JHVGJYWmlHY0ZjZnczTURlL0VSZXlCb2FKVm9PQVlUZnNLZnQy?=
 =?utf-8?B?ZVUvQ29ZVTgxN29JaWsxUko3L3R0MC9VSTI4MXpkUFdyN2hxYjRLaG4vUzVt?=
 =?utf-8?B?VXg1a1dmNnJEbDc2RHJ6azFyUktSTDBtN0NhUUtaSlpoMXVSZXFmYThibmpR?=
 =?utf-8?B?MzU3eVdQMlhkQ3dlN0JGczFleFEvR2xHTkNVRDBNMU9TKzhSQXcwS1JQQmNG?=
 =?utf-8?B?SWdMTitiTkdFK0hROHJ4YjgyTzcrZWk2aDRHWGJjV3BGM3IyUXN3c0dYb1hC?=
 =?utf-8?B?Z2NWalNEZXVCeVJxUnpsblhEZUE2RDJCVXBPUU5PZEFTQ2pFcEMxUHdDSENJ?=
 =?utf-8?B?YndjVTV1TU5VRlJMTkZHK3JlRWU1YU9ZbnJqK2tLT1lTK01TL1M0T0IraGtr?=
 =?utf-8?B?U2RJcUNEWHgzMWZWRUcvYU9MS0FCTCs2Y1hyd0NVY3c2cldqY0FNV0R6eXl6?=
 =?utf-8?B?YUl5VTVvVUFFQWErd3cydmpxWGFBWUVsT2I4dEdnbWoxMEFaNWpoSHNxbHho?=
 =?utf-8?B?Slh3TzFVLzNhT1l0WDhocjVSdVVnWFJrbm5zWUh1aUhJOVBkaTVQdEpONFhO?=
 =?utf-8?B?S1ZmUjE0V0xsUlozTmNlNnEwRklRWXNtV1JvY1RPTzhVcVVXaTROb2VZcVh5?=
 =?utf-8?B?cjVqd1lzaURpTDlBeHNnblFrNnNlRm4vZ0k1QjVERDB0RWhpOHB3NW0zSEFq?=
 =?utf-8?B?Q25Ra0syUDlkLzlpZFVtUjNUV0hnTVNBZ0lUSHVDRzBNb0xTVWZkb1RWN3px?=
 =?utf-8?B?eVlPaUpaQ1grYXFxczJiRUd3cHpENDdTeUROVlNwQlNnb1pSRWd6RGhlWGtm?=
 =?utf-8?Q?/met718Rdj97h6kqPm2WYDU=3D?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c12fe226-b354-4257-1b75-08d9f0d0643f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 22:13:27.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRgTssZPnGX9kDgwzcLHT3XpADcZ6YqgnRkXTZNKCkqcAKsDXoAOs2HZ101DlI1RvirzWTQp4Ga+fu71DJUSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8947
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

However inappropriate this question is, I'm asking anyway, as this has 
been driving me nuts for 2 weeks and I can't find an answer.

When I set

   RPCNFSDCOUNT=16

what I thought this did was spin up an nfsd thread master with 15 
threads and the thread master would pass out client requests to the 
threads, but looking at /proc/$PID/status -> TGID clearly indicates 
these are all entirely separate processes. (I wasn't sure if ps showed 
threads as separate processes; apparently it doesn't.)

So the question is how do different client requests get farmed out to 
different nfsd daemons for service? Who's actually listening on port 2049?

If there's a reference other than the source code where I can read up on 
this, I'm interested. I looked in a couple of linux programming books 
including Richard Stevens and couldn't find what I was looking for.

This was all prompted by some vendor trying to sell me an EC (Erasure 
Coding) n+m system who commented "NFS isn't multi-threaded, NFS can only 
communicate with one server, for a shared/mounted filesystem, so it will 
always be limited to the speed of that NFS Server. POSIX/Multi-threaded 
means the filesystem is parallel and can be reading/writing to multiple 
nodes at once in a storage cluster/setup. The opposite of NFS."

I think pNFS addresses this, but then how does one implement pNFS?


