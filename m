Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBBB6E294B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 19:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDNRZN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjDNRY7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 13:24:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D08A65
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 10:24:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGurU2028711;
        Fri, 14 Apr 2023 17:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=42EkCXiGHzOgH5mSfBXUmVXCyPFluiGP/3goNFIOiz4=;
 b=Do5/RgJ8NT1HIZTKmZtooYEoulJOEpiHksBti1zpN2HY9oDKVzcTAzOPm9qmsIXrN4HQ
 URmGidqwMIvV+oCkMwuW0piaessWk7duvLg49ZiJV+i7bF/xn0WbkOZ2TnwxblZ/4q+x
 jD+VLjWrAmNdexVTUPMVwWBtbWvQchf+vQk1VmpzGpygKYNHM7PGeruL9HyzuZ7jFgPJ
 cJRlGrk/wnPt42Fhb2mZ1RwPveFi+UBFNOalNde1a5eBZkvnttwVUdpcjwn3gvF/zDqC
 j15AD7KJGJl4kgi5vpELr8sPMIPMc7lS1sGNM9Xx8qpwOzWeoXaFWjftJKwMZm0ZZQWD Zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etxb23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 17:24:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGMiqv026965;
        Fri, 14 Apr 2023 17:24:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwecepvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 17:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLRvFPHOidpWman+aAMSSJMci2CiiHuTEtzh7yoDifpmIWGoKCCpxmk6N8DHr6JI8r8Av9h+rcSXUGJRKbJwmFPQY8Y5gxZBXI08ILdB/g8lic8uute0M1gwU5ZVdDW6uD9BNdQIW+XllttEIA2i+PtUe24gFeNrefys3VGqGOehnP5uRQNU6P99tNGtgMaBj03m2E6xkVZ7ODWmtsBjt2TaLCPe2mHsCkqCd6QImTf82iCskIRzGb9j/vd6QEn+9YLLtp+P7FKAzTpJ71WTuIYxdY346WmviFSja1E49vy82QIxA6QBv3Thxd3Ea6Uv1eGnNkmTQMYYdws0V8HxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42EkCXiGHzOgH5mSfBXUmVXCyPFluiGP/3goNFIOiz4=;
 b=AXWyoBghMCmwferYoDejleLer/g6fIs9zpBk6e2mBKM3fKf3TqLhegAehe8NZylPMddSCjWWcJm+LJNEXk8sDZFEnwOIwXRgH58SODtZiVWfjJz3ztj0UnK5aiFAJTSgw/0377E2IX9sRk5hjzMt2WCBCRZIFR17PC3izWwMqlZtfCz0GMlCzzmM+EqIWF8fAPeu0kKrKe0fstMgie8fPgOfYsZQe/GQyDiagm2DZ5tJd2jBVEPZMXaBJwfNqAeFSDouORh2lK6hQoaYrJeeK3+mirgMLtskkjnmUii3Ki4W6zixCJqtzE/LH5Y6C9abDiS/yNlRNMebB1ii6OuZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42EkCXiGHzOgH5mSfBXUmVXCyPFluiGP/3goNFIOiz4=;
 b=TJLm1PsFwUFWC8mMijVWTXEo3zcEIiJFuG+71ReFdbQ9sfxIvuPXfTpy2tCYwn/l7KdKAKW+qpLOGQ5aKirG//0pcI0/PMYeVAztRrPXyAUwTrBtl1hZ5QSrW/I9enL7780yu3dm/HJ4KAXmFb7RbiTii4Kmf65z+UwSKApW/E4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH3PR10MB6763.namprd10.prod.outlook.com (2603:10b6:610:147::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 17:24:27 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 17:24:27 +0000
Message-ID: <6ee0d21d-109b-9cba-f9a4-df58e929bfd7@oracle.com>
Date:   Fri, 14 Apr 2023 18:24:21 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>, bfields@fieldses.org,
        linux-nfs@vger.kernel.org, 'Frank Filz' <ffilz@redhat.com>
Subject: Re: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock
 request
To:     Frank Filz <ffilzlnx@mindspring.com>,
        'Jeff Layton' <jlayton@kernel.org>
References: <20230313112401.20488-1-jlayton@kernel.org>
 <20230313112401.20488-6-jlayton@kernel.org>
 <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>
 <c82e4b32-5df7-20c3-d0a8-4a30b9ae4482@oracle.com>
 <082c01d96edf$311da8d0$9358fa70$@mindspring.com>
Content-Language: en-GB
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 xsFNBF8EmckBEADY7zXjHab4thpE0tJt04MQJYJKBt72eXTweUlzrny8e55IrVpNI6ueSzD9
 bmTRscSqXNgBHbxOxDpajZpELgLm5c6nXjrmc7H01jWvMbrXheWWYJqp3rAohb2TgKn3iU/X
 1JasxFPghPyAvPgvJkRVzBuiKpcg3iPOUId7Q6GNinXZvOKvEWaP7G5abVZUQOT4DTTCPDWY
 ENTDwEL8nonRCIw/ip26WBoFsuUrW981X/Vch46otvSZay5ewiBL/ZO45JxIJdtMglLGoEC0
 AVrTb3TU/EHMCO5GjoWPt9xxMixG/Wtl/8Ciz0PHnJGT4a0LcNgXYWdecIS0GsBxCznGcLnI
 NLYCdoY17DuUsFC3P7EBpiS0ew0hlHAJt/jjX2AjqI/GXptzUm/sc8td99of2ksYZ8O+vmgK
 As/mbNuPyvd6skTh8R8xEZZ9zGhNmGxPP7Xd/Eud3ShF9oqx4lTj0eZYy5oWzmLFTN1D1uBj
 U+aitbp9TPyPVgqxm57p430CY9EiRocvfarWTOEEswgorumrPQzdtspxtqCZd3AfN3EMvKT/
 YtBO+OQHW9ljZNi3VjBgeH7DlXBQDLaJh6MzqX3htRIDumPhTA0kMaQQahcGicoe6GP/Eox2
 m7fulWq8AGDpwufNdV4WOSt86D4h8orUCz5sctIDnxg9PZjzUQARAQABzSZDYWx1bSBNYWNr
 YXkgPGNhbHVtLm1hY2theUBvcmFjbGUuY29tPsLBjwQTAQgAORYhBNRgW60GIMfKPVXcPoUj
 7wBtwVPiBQJg13tpBQkFiBmgAhsDBQsJCAcCBhUICQoLAgUWAgMBAAAKCRCFI+8AbcFT4rAq
 EADCFC7e2bNWFiGWse+fmz8DdiLjlV3vRgT39mHjsM1UM8t9xz+Kq3hHDhhPVscEtaegNHji
 lrNj8YeX9FQg73+QOpg57ACQSg1o1AxnTbF3sUzUt2yPDXTmXyvRvL1ytXAy0luqXnDD0OaV
 DMyOsPy/VDBbnUyVINRemBNyTAWjhwlFEcaN0jRLq6mB7mJminN6sOXKXMJswfUE1XX1aU7H
 dtG92E+19iUMIsLNyhlbKOYMI11WbI3bjPw1fWzPA4FG4tyDXqs31RdvCKCRV/mtfHi1urN9
 fTwLOIiqPeBH6m7XMlpIotIr78LmCPC2c9cugtWft8A35oN/3uHkVMlFNCCKHPNuNLAhyoxT
 JHNlmkXXXJyMhDwFcHiDhXSZSZa2FK3BtFliwvW0VdL3noDUebQuD6jhmeqIppZSwCLczPmy
 o+t3qRZKUrO0cYricoswWq6qmST8RO+cse91Or1+eaQP2xFBYi5u3b0idOhyV0D085VYVEY1
 bLO22SDQWInAwiMZv1aPJzYNDA0wBCHvf/Qvq+luHvIb2Lmy/Rje8FAgoTXYa1KjCITWeZZA
 ZkDpa8+x8JD6ECjrhEwqCKpAmWXyb0lbLrbn2lvORNc3SRwwQcLoJIkttZsUQlvu6TcyvcX9
 2BZlAN8q9PNEwXZKS/SQStzy6hsRutxmONCfGs7BTQRfBJnLARAAxwkBdfVeL7NMa2oHvZS9
 LOy2qQO3WVN/JRmyNJ4HF/p33x9jwemZe8ZYXwJBT7lXErZTYijhwTP4Ss6RFs8vjPN4WAi7
 BkBU9dx10Hi+UrHczYrwi7NecBsD4q2rH4xs/QoN9LNJt4+vLzh9HqlASVa+o2p5Fs3TyNSB
 qb4B7m55+RD6K6F13bfXM84msz8za2L9dxtjtwOyOYFeoODMBhdkMourO+e2eSxOtecJXpld
 x1LZurWrq7D79wmVFw/4wP+MOAHKPfpWo/P18AfXEW9VD5WBzh9+n8kquA0C8lnAP9qRxtTs
 IAicLU2vIiXmiUNSvAJiDnBv+94amdDGu6aJ+f2lT2A5+QHNXb0QeaV2ob8wzCOOwZZG5hF9
 9zbS0iVR+7LgnJsoJYcKVrySK5oYfAFMQ8tUA102dZ6lHkVdRw77mIfbaXB637SAIxJGpwI1
 bDw3+xLqdqJW/Rs3BDSGrJRMPE1MnfvaAPfhqWSa9aFZ7wZPvO9sm9O5zO3R08COqCLgJxNO
 AVnJCw9aC5X1XzWyQvE3NA94Afl3KVAU1uxtgTpnwP5J05SllpSXeF4DpnH+sFX4+ZS4Cx+V
 96DgYY3ew6/SUGdMbEfJsqelCqz62vHguMA4cLIMbOnbh9CkGsYeJEURixCywgft5frUtgUo
 5StuHFkt4Lou/D0AEQEAAcLBhgQYAQgAJhYhBNRgW60GIMfKPVXcPoUj7wBtwVPiBQJg13tp
 BQkFiBmgAhsMABQJEIUj7wBtwVPiCRCFI+8AbcFT4ttZD/9qlKLLkkYsKUO2nhD9L3PmnHv0
 eFyAh23IR/PZ3yfqNuN56n6qurgYyhWVqK2HjvRod4YVoPonPqrxlSYvbmIWqSBwqKu8Vp5z
 RDA37EqID3kSehKa9PaHVGk6jGgakr81RSb8M82sFsy5uNXUDnd6WrZIldoPix2uCuKTwrbq
 7VlfD31W4fDXu2sCdK2QVzwmsgAMM6++lb+DdN70h9lQl740wAo5HFjeH5bz22q9PrCIDrXS
 sH0zVwJAGEVA3VokJFc7Y+jukz26SpUD+mhYIIt2Y4RhabrBfo7edmWH3G9ui8hJT6P46S+U
 8ydsl4WQKnFwXF29BhKWgBnOj13xpI/TLZ4/9ZtRXlYvd384JmkvSIicYpQMAym5i+PyIvaU
 l0xV5hJ5mhBEEBMkjab8t6NPn/CWVq1cxgawascZYzIQkZBLCRctQtumkb+KVkr6M6aL5q3w
 25RYSMgLQud0CiijFCsMcDztj62TpbnicYLktbOeXXd9rxA+UUEK+sRu8TkRmvEsqDMteo1t
 CCmjhrGESci4r2acbD4eb1O+y2lFQtq1JuywoxKvRt/a1arwW5xDslw/5ycViv+emPmoY73h
 MkByMn3Tf4MIjhceT4YoulFFGF1WetO3M39GkqcI2DfnYL9OV7YMYtuDz3ianbzg/S4qDxN4
 gx3r8uLHNg==
Organization: Oracle
In-Reply-To: <082c01d96edf$311da8d0$9358fa70$@mindspring.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kdGZzxQUMfaVjRgpSUrApfqF"
X-ClientProxiedBy: LO2P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::15) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH3PR10MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: fc45cb4d-c195-49eb-b84e-08db3d0d1931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvqeYbv6fUI3N60Yb0uAMceOjKr85E3Vh2MRYwVG3o6u77BPZI31H6OFqJLzc+Rb8PgjaE4GSx8DpoCpRf4I/L8guZhh3vgEajnJ20ly5GUmf5sXEpGuJFxi+/0n9cQPgAAnMX03s34ZMaB2Zz5CGlzLioEPsmpuHy6a+kO6WReTShhAycMk2yp1GReg+31cExINdoAy2S6V8dJE46KbamihkdrXLMtP5x24MzIsDed+0Tx6aR01MaUj8Qd+dOgqg4TWMmyCjSu3Fo7SQVLY7EsraiAWl84wrEVmSmTSh3ehzZUZSn85b3wjYFhzhJN4Lh6ttujNioGYz7LiavdeCI6GRnDsnax2X0TTWiHsbPgfs7srvyg35CAMQ6rKXj/oH8WupwYhe1Kxzzj0I8J+ZtOOVRDdIfaOnHO1R/Uqq6QDUgFdfpMZV041FsLHIyArt9u0+MWP3i43jV1aNBqtaVuNFpjYmCf33htQ/X0kOfUcL+WCL/HoU9NLndksKPEdgsV3FGnQkdv9uZLVnIQKyY/368C3wnrX98Z4cQB0TZFzdxMBErskM576arcKmVYdJc5Hqoe9qJb016qTZRjvwHUO5JuM4JecWZyfFLZqiaTdk+tIPy4gFD0+7vgUouXgU/T43c5AJCokj64PjzOK2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(110136005)(53546011)(26005)(31686004)(6512007)(6506007)(54906003)(186003)(83380400001)(2616005)(21480400003)(36916002)(33964004)(6486002)(6666004)(5660300002)(41300700001)(235185007)(316002)(8936002)(8676002)(38100700002)(86362001)(478600001)(31696002)(66946007)(36756003)(4326008)(66556008)(66476007)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFSdDBGREp1NEJTYlZPaVJqYjZHQ1Y3VHV4Vy96YS9sM0c5emkyYXBDTTRz?=
 =?utf-8?B?RW9ob1UvZ3Z6RVlNY2VzTWp5aGhaR1Jtc0Y1bVltSEJXZ01wOC9oZTczYzJJ?=
 =?utf-8?B?bytYb09CWDFqNm8zN1lmTWQ5RXN1L2tFdVFwMmhtbjJlSnRyd09qYXJpM29I?=
 =?utf-8?B?Y2l2Ymt3T1B3REk4emF1bWRIZ3BQNUFoTHk5ZlhCTXZob2Zza3lkcjlSbU1m?=
 =?utf-8?B?RkJHNC9JUGFXOS9QSTJPK3N3VWFZVjRCOTExdUtKdlowdmdUemtoWmd0QTFB?=
 =?utf-8?B?RU5QUWQrNnM2NGpVM2o2NUxHTS9wQjFOUW1DTjNYWkFLMTluTmRwdWhVbFdj?=
 =?utf-8?B?M0NFVkgxVENBL3JjdmxpRzAxQW1uYWNtTndLcTlaY21lMGtETC92dk9sekxJ?=
 =?utf-8?B?c2lCR0NsdU1VaDY3TE9UR1FwM2I1cDJHNlNZWnk1L1FpMnVkc0N3dFhWdGJW?=
 =?utf-8?B?UmtDMkRPMjVYK29HRVJybWxtRUprc3VHY3FIUFo0WWozclkzWnpVM3ZBdEUr?=
 =?utf-8?B?c0FDUDlmcEJPV0YvQU1HV0RYRGxmMm9NRTFDblhlQ3pTck9CbE1HWjZzRHBG?=
 =?utf-8?B?ckFWZ0VYZEFHNTBZTUF4aWVRZ05vTkU0aVhIMkxjZ2Z0U3BZWFJnMkU1QTQ2?=
 =?utf-8?B?Um96amUrQ3BnVWNKUjdpdTlPS25vUHJKMDUrWWZpWXJKaTBJejVUbmplRTR3?=
 =?utf-8?B?Z2FISFEyNlRSS2JTSDhTcHI1TnBCRWRyTHBXTmJydjFYZzhLbzhOcGRSWU1u?=
 =?utf-8?B?VExOWklpcjhab1pjdGtZTS94bFJNRXN5SFd3SXZMMnpQTGdZK0d2bitmMTNP?=
 =?utf-8?B?RzJZaklRMmZOT1V5aldjYkZoU0FKOU5HYkpYb1N2ZG12ZzEycEp3enE4bVEv?=
 =?utf-8?B?NEZydTZUM2NkK2EwMmVaaWFuMENrcjdIQ0tIWDJidTBLcXpjWmlwYStGYUMz?=
 =?utf-8?B?d2o1aVVRbjBSNnJaK01ZNDhscUlGZk5oZ2FFOFNMNEVjWVQ4eUw5SmY4eXY4?=
 =?utf-8?B?bDN5TDJzS1BIOERjZGNya3hyMkN3a2tZSmlNM1N3L1Zjc3Y0cHptbEQ1VGpS?=
 =?utf-8?B?RnYvZGNKK0ZUNzlsRVpYNGJvbEVVZ0ViY3dUdFI3dk1vWldHRmRyUkNkb0cy?=
 =?utf-8?B?ZnpON200Y3RtU3BpUWtTLzJKOFV1M0Q5N204RERFTHovUkdGZXlVaEM0YTBU?=
 =?utf-8?B?Z0x3Unl0ejNpeEl6eGFjb2xOaTQxY1NyTElGU3owWkR3Nmk1NFpPaEdxSUtm?=
 =?utf-8?B?YWk1YzFjb2UvOFpPZmwzTE1nUExoMXVQRW5NVWhCd2tneXRnTGdOWEVlZ1pW?=
 =?utf-8?B?UXJ6WXBLaWh3Vm1OaHNYMlMyc0g4RllMSFFDUDF0SXUrLy83emJFa0N1U3NL?=
 =?utf-8?B?Sm9FS1Y0dkZMZ0pnVFIxS0NmTk1XUnRWWDNEc2tOSWVwby9tOURVVnlIbEpt?=
 =?utf-8?B?WTQwNXZ4Q1czc3dpUWgxRFBOUVNGTndOS3hMa0ZOQ2p6V2VrN3JMRTBSSm1k?=
 =?utf-8?B?Y000TEs0RlBCU3lLb2VSNHhVZzl5WFAzSGNBU0Z2UkczNCtSdHZuK1pLOC9t?=
 =?utf-8?B?TGxWbjVMSC9UNFNaV3MyZks5L1p5SUNYWWM2aVp5SVpNV1RYeW90WE5jUU1B?=
 =?utf-8?B?cUlNVFZ1TnJjNlkrMDkrWlg4S2dQVWJJUTF0bDNBbTAvSEk3RnRMeHBCR25p?=
 =?utf-8?B?VDdGTVRhbXJpZ1RUNEtXOUViaERTcUZmdDFubis0L1l0dkQ1a1VpNzN0TDdr?=
 =?utf-8?B?cmRRSE5rN1hoakNIbWJrWE4xanIyVGNTTjUwSFlUN2I0TjRDTXg1VGt6MENx?=
 =?utf-8?B?aWllSjBCS2FNdjhlbk5RK2hMTnp5S2F4VHdpd0FjbFZmb1A3TXhsc1Y3UkdY?=
 =?utf-8?B?bjFiOXp2cVJsYW5pTkU5Y0hlM0M4Ulpla2JmaWZ2bzNKandFcWJjMWp5Y05G?=
 =?utf-8?B?eUdYam1rbk11SVVQeGdLL2Z2bXI2Z2YzK1dWMFFvU3N2dlowSVRFclhCVVh6?=
 =?utf-8?B?OTZIUVNSNC84L2NhY1BwbC9WQUlpRXo3TVNaT2NBOVd6T2xPVVhaNnhYcEI4?=
 =?utf-8?B?TldlZVZVeUxDM093OUhXUkJTSHBJMUJROUg1UXFrVnJqYmdUbVI0RTMrWTA5?=
 =?utf-8?Q?SVwRYtMNRVzo6DLGTnTUu7luv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wf5Rmrtb00ldyeSHUqF0CKXGUUsg7hjTMIk/7e14zGI1isaGJISxv15674mDI0ppPeBEe4dVRFfIPKNKTL+Jnshm6DUfXLqeRRC+qLoHZOFeuXUnc0zKOSi6pZmJq+OGw7yAJrm1qg99RToPl0D+La7YCagPjXZgwPq2EL81IKKu+laWjHXZTG6uhwTzuWahmgl2UJ9/fpcCDBZH/3LGLmrCON48P/BeoL8fqLg9i/Pww7mTOJMPKev3yQT8DzzW8mpco2xzGH5WEI52GSbFqqoHMUEBOw1ThTgHi6cFnHvOXnY4VCgksdg6TQjfyKuawz31ao3OHb8ZTgc3yyVY2/aYqu2vFoHgprmV1dcwkr6ZwGRxD//LsTYXndZGkdv9TQdBHPfTNw73xHNFP3UuL91e3yhjk7Hw//D0w7w5oCfFnboEoAi7X0ZDshU2CruWT8RiJFNyWsjFLR7JYJyEyTH70+sibBAb92OUrrMc2ma8mK+l2vwg17C9lgk8dmPhoqg5aj+j/YMOQZSkWMfQF4o4s5RaL9dtgRjRC7z6YtczFhC0K1JoE6wsWj7CebTI3IMN1c+4VvR4lUYSBKlM3HqGJpz7iDQojWBbH/MjI2owzegoar7etOaZbaT4bo1Z1/2HH/s7pDRXnFbc8gxc9ikkR8Fc3z/cP8HI/QZMycPTjPVb0fgELsi7VmGTyNXOCYLsEkZJoZxZMVqfBAbMtIqYNaSmsTHJVnmfBznnx/DV1VE4Q0/g+eopFTxE0adxoxfTwEAhH8c3vetoaNrsid8mCNFqPkbeD2/AMz9HZiU9Xa3cmZC61t5qkp1VkNx6KyaA1ipTQz7Yst6QLbWzFNLb3x5M3iXmqXIZ0yL9prT4EnABP5uTjR0U6AjzeJyqovRJReyorJBvViSrkMVxXA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc45cb4d-c195-49eb-b84e-08db3d0d1931
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 17:24:27.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a79rDlvpLT877PWSqVkv5xg206z3Ar22hgWyyvdnlCkw7DfEiLEWoNv9LJhzkuyT7V85kz5zgzJFVj/m6Wns0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140153
X-Proofpoint-GUID: -2N0qq8bgurWGEupsAPyugww3VzFtsGR
X-Proofpoint-ORIG-GUID: -2N0qq8bgurWGEupsAPyugww3VzFtsGR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------kdGZzxQUMfaVjRgpSUrApfqF
Content-Type: multipart/mixed; boundary="------------9FJ0Stfgl070qehVl1xF8wwx";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Frank Filz <ffilzlnx@mindspring.com>, 'Jeff Layton' <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, bfields@fieldses.org,
 linux-nfs@vger.kernel.org, 'Frank Filz' <ffilz@redhat.com>
Message-ID: <6ee0d21d-109b-9cba-f9a4-df58e929bfd7@oracle.com>
Subject: Re: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock
 request
References: <20230313112401.20488-1-jlayton@kernel.org>
 <20230313112401.20488-6-jlayton@kernel.org>
 <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>
 <c82e4b32-5df7-20c3-d0a8-4a30b9ae4482@oracle.com>
 <082c01d96edf$311da8d0$9358fa70$@mindspring.com>
In-Reply-To: <082c01d96edf$311da8d0$9358fa70$@mindspring.com>

--------------9FJ0Stfgl070qehVl1xF8wwx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQvMDQvMjAyMyAzOjQxIHBtLCBGcmFuayBGaWx6IHdyb3RlOg0KPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IENhbHVtIE1hY2theSBbbWFpbHRvOmNhbHVt
Lm1hY2theUBvcmFjbGUuY29tXQ0KPj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDEzLCAyMDIz
IDExOjM1IEFNDQo+PiBUbzogRnJhbmsgRmlseiA8ZmZpbHpsbnhAbWluZHNwcmluZy5jb20+
OyAnSmVmZiBMYXl0b24nIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+PiBDYzogQ2FsdW0gTWFj
a2F5IDxjYWx1bS5tYWNrYXlAb3JhY2xlLmNvbT47IGJmaWVsZHNAZmllbGRzZXMub3JnOyBs
aW51eC0NCj4+IG5mc0B2Z2VyLmtlcm5lbC5vcmc7ICdGcmFuayBGaWx6JyA8ZmZpbHpAcmVk
aGF0LmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBbcHluZnMgUEFUQ0ggdjIgNS81XSBMT0NLMjQ6
IGZpeCB0aGUgbG9ja19zZXFpZCBpbiBzZWNvbmQgbG9jaw0KPj4gcmVxdWVzdA0KPj4NCj4+
IE5vdyB0aGF0IEkgaGF2ZSBzb21lIHJlcG8gc3BhY2UgKHRoYW5rIHlvdSBUcm9uZCksIEkg
YW0gcHV0dGluZyB0aGluZ3MNCj4+IHRvZ2V0aGVy4oCmDQo+Pg0KPj4gT24gMTMvMDMvMjAy
MyA2OjUxIHBtLCBGcmFuayBGaWx6IHdyb3RlOg0KPj4+IExvb2tzIGdvb2QgdG8gbWUsIHRl
c3RlZCBhZ2FpbnN0IEdhbmVzaGEgYW5kIHRoZSB1cGRhdGVkIHBhdGNoIHBhc3Nlcy4NCj4+
DQo+PiBGcmFuaywgbWF5IEkgYWRkIHlvdXIgVGVzdGVkLWJ5OiwgZm9yIDUvNSBwbGVhc2U/
DQo+IA0KPiBZZXMsIGRlZmluaXRlbHkuDQo+IA0KPiBGcmFuaw0KPiANCj4gVGVzdGVkLWJ5
OiBGcmFuayBGaWx6IDxmZmlsemxueEBtaW5kc3ByaW5nLmNvbT4NCg0KdGhhbmtzIHZlcnkg
bXVjaCwgRnJhbmsuDQoNCmNoZWVycywNCmNhbHVtLg0KDQo+Pg0KPj4gY2hlZXJzLA0KPj4g
Y2FsdW0uDQo+Pg0KPj4NCj4+Pg0KPj4+IEZyYW5rDQo+Pj4NCj4+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogSmVmZiBMYXl0b24gW21haWx0bzpqbGF5dG9u
QGtlcm5lbC5vcmddDQo+Pj4+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTMsIDIwMjMgNDoyNCBB
TQ0KPj4+PiBUbzogY2FsdW0ubWFja2F5QG9yYWNsZS5jb20NCj4+Pj4gQ2M6IGJmaWVsZHNA
ZmllbGRzZXMub3JnOyBmZmlsemxueEBtaW5kc3ByaW5nLmNvbTsNCj4+PiBsaW51eC1uZnNA
dmdlci5rZXJuZWwub3JnOw0KPj4+PiBGcmFuayBGaWx6IDxmZmlsekByZWRoYXQuY29tPg0K
Pj4+PiBTdWJqZWN0OiBbcHluZnMgUEFUQ0ggdjIgNS81XSBMT0NLMjQ6IGZpeCB0aGUgbG9j
a19zZXFpZCBpbiBzZWNvbmQNCj4+Pj4gbG9jaw0KPj4+IHJlcXVlc3QNCj4+Pj4NCj4+Pj4g
VGhpcyB0ZXN0IGN1cnJlbnRseSBmYWlscyBhZ2FpbnN0IExpbnV4IG5mc2QsIGJ1dCBJIHRo
aW5rIGl0J3MgdGhlDQo+Pj4+IHRlc3QNCj4+PiB0aGF0J3Mgd3JvbmcuIEl0DQo+Pj4+IGJh
c2ljYWxseSBkb2VzOg0KPj4+Pg0KPj4+PiBvcGVuIGZvciByZWFkDQo+Pj4+IHJlYWQgbG9j
aw0KPj4+PiB1bmxvY2sNCj4+Pj4gb3BlbiB1cGdyYWRlDQo+Pj4+IHdyaXRlIGxvY2sNCj4+
Pj4NCj4+Pj4gVGhlIHdyaXRlIGxvY2sgYWJvdmUgaXMgc2VudCB3aXRoIGEgbG9ja19zZXFp
ZCBvZiAwLCB3aGljaCBpcyB3cm9uZy4NCj4+Pj4gUkZDNzUzMC8xNi4xMC41IHNheXM6DQo+
Pj4+DQo+Pj4+ICAgICAgbyAgSW4gdGhlIGNhc2UgaW4gd2hpY2ggdGhlIHN0YXRlIGhhcyBi
ZWVuIGNyZWF0ZWQgYW5kIHRoZSBbbmV3DQo+Pj4+ICAgICAgICAgbG9ja293bmVyXSBib29s
ZWFuIGlzIHRydWUsIHRoZSBzZXJ2ZXIgcmVqZWN0cyB0aGUgcmVxdWVzdCB3aXRoIHRoZQ0K
Pj4+PiAgICAgICAgIGVycm9yIE5GUzRFUlJfQkFEX1NFUUlELiAgVGhlIG9ubHkgZXhjZXB0
aW9uIGlzIHdoZXJlIHRoZXJlIGlzIGENCj4+Pj4gICAgICAgICByZXRyYW5zbWlzc2lvbiBv
ZiBhIHByZXZpb3VzIHJlcXVlc3QgaW4gd2hpY2ggdGhlIGJvb2xlYW4gd2FzDQo+Pj4+ICAg
ICAgICAgdHJ1ZS4gIEluIHRoaXMgY2FzZSwgdGhlIGxvY2tfc2VxaWQgd2lsbCBtYXRjaCB0
aGUgb3JpZ2luYWwNCj4+Pj4gICAgICAgICByZXF1ZXN0LCBhbmQgdGhlIHJlc3BvbnNlIHdp
bGwgcmVmbGVjdCB0aGUgZmluYWwgY2FzZSwgYmVsb3cuDQo+Pj4+DQo+Pj4+IFNpbmNlIHRo
ZSBhYm92ZSBpcyBub3QgYSByZXRyYW5zbWlzc2lvbiwga25mc2QgaXMgY29ycmVjdCB0byBy
ZWplY3QNCj4+Pj4gdGhpcw0KPj4+IGNhbGwuIFRoaXMNCj4+Pj4gcGF0Y2ggZml4ZXMgdGhl
IG9wZW5fc2VxdWVuY2Ugb2JqZWN0IHRvIHRyYWNrIHRoZSBsb2NrIHNlcWlkIGFuZCBzZXQN
Cj4+Pj4gaXQNCj4+PiBjb3JyZWN0bHkNCj4+Pj4gaW4gdGhlIExPQ0sgcmVxdWVzdC4NCj4+
Pj4NCj4+Pj4gV2l0aCB0aGlzLCBMT0NLMjQgcGFzc2VzIGFnYWluc3Qga25mc2QuDQo+Pj4+
DQo+Pj4+IENjOiBGcmFuayBGaWx6IDxmZmlsekByZWRoYXQuY29tPg0KPj4+PiBGaXhlczog
NDI5OTMxNmZiMzU3IChBZGQgTE9DSzI0IHRlc3QgY2FzZSB0byB0ZXN0IG9wZW4NCj4+Pj4g
dXByZ2FkZS9kb3duZ3JhZGUNCj4+Pj4gc2NlbmFyaW8pDQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+Pj4+IC0tLQ0KPj4+PiAgICBu
ZnM0LjAvc2VydmVydGVzdHMvc3RfbG9jay5weSB8IDYgKysrKystDQo+Pj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL25mczQuMC9zZXJ2ZXJ0ZXN0cy9zdF9sb2NrLnB5DQo+Pj4+IGIvbmZz
NC4wL3NlcnZlcnRlc3RzL3N0X2xvY2sucHkNCj4+PiBpbmRleA0KPj4+PiA0Njg2NzI0MDNm
ZmUuLjlkNjUwYWIwMTdiOSAxMDA2NDQNCj4+Pj4gLS0tIGEvbmZzNC4wL3NlcnZlcnRlc3Rz
L3N0X2xvY2sucHkNCj4+Pj4gKysrIGIvbmZzNC4wL3NlcnZlcnRlc3RzL3N0X2xvY2sucHkN
Cj4+Pj4gQEAgLTg4Niw2ICs4ODYsNyBAQCBjbGFzcyBvcGVuX3NlcXVlbmNlOg0KPj4+PiAg
ICAgICAgICAgIHNlbGYuY2xpZW50ID0gY2xpZW50DQo+Pj4+ICAgICAgICAgICAgc2VsZi5v
d25lciA9IG93bmVyDQo+Pj4+ICAgICAgICAgICAgc2VsZi5sb2Nrb3duZXIgPSBsb2Nrb3du
ZXINCj4+Pj4gKyAgICAgICAgc2VsZi5sb2Nrc2VxaWQgPSAwDQo+Pj4+ICAgICAgICBkZWYg
b3BlbihzZWxmLCBhY2Nlc3MpOg0KPj4+PiAgICAgICAgICAgIHNlbGYuZmgsIHNlbGYuc3Rh
dGVpZCA9IHNlbGYuY2xpZW50LmNyZWF0ZV9jb25maXJtKHNlbGYub3duZXIsDQo+Pj4+ICAg
IAkJCQkJCWFjY2Vzcz1hY2Nlc3MsDQo+Pj4+IEBAIC05MDAsMTQgKzkwMSwxNyBAQCBjbGFz
cyBvcGVuX3NlcXVlbmNlOg0KPj4+PiAgICAgICAgICAgIHNlbGYuY2xpZW50LmNsb3NlX2Zp
bGUoc2VsZi5vd25lciwgc2VsZi5maCwgc2VsZi5zdGF0ZWlkKQ0KPj4+PiAgICAgICAgZGVm
IGxvY2soc2VsZiwgdHlwZSk6DQo+Pj4+ICAgICAgICAgICAgcmVzID0gc2VsZi5jbGllbnQu
bG9ja19maWxlKHNlbGYub3duZXIsIHNlbGYuZmgsIHNlbGYuc3RhdGVpZCwNCj4+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgdHlwZT10eXBlLCBsb2Nrb3duZXI9c2VsZi5sb2Nrb3duZXIp
DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlPXR5cGUs
IGxvY2tvd25lcj1zZWxmLmxvY2tvd25lciwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGxvY2tzZXFpZD1zZWxmLmxvY2tzZXFpZCkNCj4+Pj4gICAgICAg
ICAgICBjaGVjayhyZXMpDQo+Pj4+ICAgICAgICAgICAgaWYgcmVzLnN0YXR1cyA9PSBORlM0
X09LOg0KPj4+PiAgICAgICAgICAgICAgICBzZWxmLmxvY2tzdGF0ZWlkID0gcmVzLmxvY2tp
ZA0KPj4+PiArICAgICAgICAgICAgc2VsZi5sb2Nrc2VxaWQgKz0gMQ0KPj4+PiAgICAgICAg
ZGVmIHVubG9jayhzZWxmKToNCj4+Pj4gICAgICAgICAgICByZXMgPSBzZWxmLmNsaWVudC51
bmxvY2tfZmlsZSgxLCBzZWxmLmZoLCBzZWxmLmxvY2tzdGF0ZWlkKQ0KPj4+PiAgICAgICAg
ICAgIGlmIHJlcy5zdGF0dXMgPT0gTkZTNF9PSzoNCj4+Pj4gICAgICAgICAgICAgICAgc2Vs
Zi5sb2Nrc3RhdGVpZCA9IHJlcy5sb2NraWQNCj4+Pj4gKyAgICAgICAgICAgIHNlbGYubG9j
a3NlcWlkICs9IDENCj4+Pj4NCj4+Pj4gICAgZGVmIHRlc3RPcGVuVXBncmFkZUxvY2sodCwg
ZW52KToNCj4+Pj4gICAgICAgICIiIlRyeSBvcGVuLCBsb2NrLCBvcGVuLCBkb3duZ3JhZGUs
IGNsb3NlDQo+Pj4+IC0tDQo+Pj4+IDIuMzkuMg0KPj4+DQo+IA0KPiANCg0K

--------------9FJ0Stfgl070qehVl1xF8wwx--

--------------kdGZzxQUMfaVjRgpSUrApfqF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmQ5jEUFAwAAAAAACgkQhSPvAG3BU+Kn
/Q//ek4zofKYCP9dPGnWub1N6b/Urkyz8DrsYltU4WeCX3JvmSU53o1Web0+HkXPFtznPfE+Xk3r
hqJCxzcXPUMvqg4T5tjBMpYXb4HUoHbcFKhT3LeHTwbrfMHA+xyrflsP7W1uVKQ6U/cEF/OQxhyu
/ZRboRxdSGmgFbt/v64aVWYpXqwximl24PG9xfRzFQzEJ+mSvbfofsST3l1lLa70mnsg92QUU8ZN
vky9g4+RL9Iaq+eKxHhkZAEvYzYaosX1BeEQ5IrLE7bJnsyIWPgMdfNTKSiKJziqDFlurlA26XCs
fEcOHyRESo1Y4busohN4OAXWRKiWYD6/xVYpmJQCJ3QKHnPsyQIw5sfrprlhMG+UhcB1mEsoMxSF
88QHMeGka5LGuWO9apVqei3UiA2wCe4ND9jaTgHwpTjcaj3jq2tzWzYTLI+kRbkbsVJKSxpiFzBQ
oo/LtGvCWn7iSj7XrcBfu8z3FNezhCqNIwgQ062MAneStqRGEO5y10xO8DFUP+jH+uuex6k7fdav
fZoScdqKLGPEyQCALizENaqt2Axyfiwu0pnrcKrA8myCa3TwolJWom0cSOULIBdKqvah/csvpHyz
qx0egDwiHizBwBAuBdqlRjtLDPZc8OTcyRSK4z4QWeDA5vcLN583p38+68waQ1/wctvKGStpaGdC
Jx8=
=FsHF
-----END PGP SIGNATURE-----

--------------kdGZzxQUMfaVjRgpSUrApfqF--
