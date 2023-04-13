Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629DA6E1431
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Apr 2023 20:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDMSf2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Apr 2023 14:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDMSf1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Apr 2023 14:35:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C027D8E
        for <linux-nfs@vger.kernel.org>; Thu, 13 Apr 2023 11:35:19 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DGUNhH010169;
        Thu, 13 Apr 2023 18:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=IpmFqqLMgRx9lscECIxVszLOeptidSKcPFaiPSoCA6Q=;
 b=Pls9S9YLvK8OMQCLYCFq/QWbi1u3cwqGVWlebgJ5LR5NMj4VsWS+huYnBNfn4GFgPyfo
 UMxB1gXzq2MLEoYs4SJT1YGbkcRrLHwXF1bZ307M4ojQdmETfiVZMuIP6fZTI2pwD6Wl
 N9d7Rie2+ETVv34E7Hn8TvHn0TLeCDf8GGvzBsox67V0O1RQYZIeGMwsRqrzXmtuxsP2
 iz0BKcu8w4D8eCVASSbs6/xTtTbGFZChVyfqV492pFzAAYRP5WQycFoPPKUOPmy+Fn9T
 x037TkMVnjao11324i5IfbQsertZIk7Ef92uiQa1HwWc0d1vT6l0KLxVGKm0mpg3hYy3 Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bw40jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 18:35:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DHGHYA017551;
        Thu, 13 Apr 2023 18:35:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw8ax0es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 18:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wva3zrhxXJiQcdxZxOTcC0qFRAuyPkrKVuVig43I6r0ymyKeonlyP5gUx2LOqPNu4tDNGFi5YGbB+JVTVQbVxHKVuAiPQ/nGhm2tDn7uDVMbMf+aRsaFPx7IzcM/H4IM3Kvm7NrPrjSZkR0aL3g0URhWvM7qbswVHWOyBLRZBOZcQcNeIprO9KVP8uofJx5N+ZRq3+oh4GlLgvL+znb7K2mRoaINmk/6BgUitLIeekFJXVZW0SseGty3N29NVRS4HhvpuZRai37DqENv92Jl1X0mp8Rg4pxe2Oi0DuprbHaphgJJeNWDmQAwb3Z2C6Wc6G2HNDi0mupTLDirvN/Q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpmFqqLMgRx9lscECIxVszLOeptidSKcPFaiPSoCA6Q=;
 b=UP67AqJzZEt2vgFjWuyUa6o7g4Dv9RWJtxi2fO1MvudCjMEAs34lO/v3XpiQsgF5/I0sXAJAEVYgDg5UXXxUpgVbyuWP9Sx0/0jj9LCiHuoVs7DDR5DItGD6yirVWvrRVAlsm/iZmSdoIAUHOF89bH2nxpNdwCx1ngtnorwKUrCE7J+uiClSlsmcukaaccTVQwxQepOuHyRm3nCH1l9bdyN1DfoxD4CYsGKscJ8dLlX4CV7z8HX4jByVJpd6floY3E8nv5lozl0E4nlEQHJrSTKVZ9kodYB/3qzBSv3bwlIbS8CQziIzeBuGdtzBbhuenSTUcG1G2+viSNrwTcSp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpmFqqLMgRx9lscECIxVszLOeptidSKcPFaiPSoCA6Q=;
 b=nXiFwQk9tpSawLJf3IpAYVlrLKc64LBVwyt8xit5wGTnLLHwb0dkRvbcncbEcxlrmT3iEJsfR/2PSlWm0UpE+ws/xW8o8BHhCZhubBirS1uUMMCWY/xoViQe5KuW0w12Qp3jk+2AUmnZhnuuCh6t0GB37a5c2USL8bw736ETteU=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH3PR10MB7501.namprd10.prod.outlook.com (2603:10b6:610:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 18:35:07 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 18:35:07 +0000
Message-ID: <c82e4b32-5df7-20c3-d0a8-4a30b9ae4482@oracle.com>
Date:   Thu, 13 Apr 2023 19:35:02 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>, bfields@fieldses.org,
        linux-nfs@vger.kernel.org, 'Frank Filz' <ffilz@redhat.com>
Subject: Re: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock
 request
Content-Language: en-GB
To:     Frank Filz <ffilzlnx@mindspring.com>,
        'Jeff Layton' <jlayton@kernel.org>
References: <20230313112401.20488-1-jlayton@kernel.org>
 <20230313112401.20488-6-jlayton@kernel.org>
 <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>
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
In-Reply-To: <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------09QsUMG0LHpV5CrA7OiAMb0v"
X-ClientProxiedBy: LO2P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::23) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH3PR10MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ca74cf-da41-4de8-e558-08db3c4dcdfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uwadp9C8ykco5CFdWDRDB6YlFQYW8KSPuQZ+4SVZNgCJ9FRDAKR20iJ1/cSEIcCk5cLLozfOh2G9kGktW3IFRKTjo2t2st4wHYS+WySLT/2fooQZRfzqlaKjvU0gkuBQppQr0PLGVYkuMXy+yLskvI7xJ5Vo0y0eONMnkEbpqkiNZ6E+X/WveuFaKnIgJlfcS3JtX3l6PyWfTTfIekQEppNpS7bFjuuJpSCf5YX9r+2r3xvjB9JDIzptw/+sXoF6J8hH8AZG9oME0reAm3vqEVs1sBifFZVUEQ1TVYrTNYwIZuzUGqU2RhlgOiGbD6dji+dh3dQnQl7RFnS2oEtLFmjGFjKNx+aYrCVMOCdQb3+hwt8S7kLo1wEHy57yWIXXrXfA1maMddXgkTf9+ZpAEVb1vbkNXpNGQdg8lF4NHoFAvk9AptHfR7evdxtUPXJ3GwDP8vDMJDFwxqK74l0atGXYVKw3QnqllwOIc5B/KOOnXD1VARHTOAMxMVptXjHO37ykk5BMIEq3fOuXE0SGL+eSwID8sGBtWRqT/ln0L9xvTrzTubUGnn4oX3LrVyq6nkoKaQKjHXYvrwVcqDuP9E2iN3tQ+1AyEAtBTuHTHtrIEIhYKM0Q+fltSRDSAcjVDjks5mUssSYc2XGY9iy7XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(86362001)(54906003)(44832011)(110136005)(478600001)(316002)(41300700001)(38100700002)(8676002)(8936002)(235185007)(5660300002)(66476007)(66556008)(31696002)(53546011)(6512007)(6506007)(36756003)(26005)(31686004)(186003)(21480400003)(66946007)(4326008)(6666004)(33964004)(83380400001)(2906002)(2616005)(6486002)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2lmdldWbmVwZkZkSmRDcFg4ZXhwamFSK3dBbVFnNE1Gem5sVmNNdGNoeDVw?=
 =?utf-8?B?THQzTlhac1NxRXRxWENtWXQ0ejJ5Vm8wRzVqV21MQzg4czFwam5ZTXE1TEhk?=
 =?utf-8?B?aEluNVVrYU83UkR3MFlmVXZrdjBJVEhoSFBoTHNOTk92WXBpWElkV3diUzZr?=
 =?utf-8?B?SGc3Sm1UR3hucWNSOGdtaVBPRFE4aUJqYXRoSWZESzgxMVRDcXVHaFFXOFBz?=
 =?utf-8?B?SmdKaEsxTEpBY3czWHFSMEdCNlYwdnNuVCt3ZnhlM1kxakd3elp5aEVqS2hW?=
 =?utf-8?B?MW9EOGt6OUxRZ00wQ0swYWNOUWJQVkpMejBzT2lGY3ZiQmtlWjVnS3MxSWg2?=
 =?utf-8?B?b1BXQXhnNVN0VmJyOHkvZHowRWx1YjJuUHRTbGxGUTNVT3U0TS8xbUMvVGhh?=
 =?utf-8?B?WFRUL2dqbWRqcEF2OU90WWJlYXZJeTJlTkozV0Y0ck1xTm5nOUtSa2g4VDZ2?=
 =?utf-8?B?L3VpbERVcWs2Y3ZEUUd5U24yS2Vsb3hlS3FFVzlIQ3NtUkZGeEFZS2k1WG9L?=
 =?utf-8?B?R2wrMlJnZUJMa0dBRE9PYVNUK0xveG91Y0lSZHhRNGNJR0JtVk5uZDJCV1V2?=
 =?utf-8?B?NEdBYTZKa2NRMUxRYXg5dy9tbmhRRWNXRjhxVkxubURvMnBXMWRCTndGVXFm?=
 =?utf-8?B?OEk3RHZXRE50UkN0SWcyVGFkbjNCYnhZbGtCeks1OTRoMldPQ2d2aUdHSndr?=
 =?utf-8?B?Y1BweU1yVlRVRS90a2ZlKzlPY0xEcEtTcmJqTlN5SWF4WTJWN1l1ZnpydEpR?=
 =?utf-8?B?U09qOTMrY3NNQXBGSkl2d0RzVldQaHRZSm50LzYrUUFiK1dpbnl3bWlyaWtV?=
 =?utf-8?B?dnNoREtSUHo3YUNBbzJkK0k1bWFZMllSNmVTMm9BMU1wcmRSWjZWL1NUN0tI?=
 =?utf-8?B?Nmd3UExKL3cxc044YnZZd1ZISGx0dTNuai9MalJZOXJuMUowdFNlSUV0ZExq?=
 =?utf-8?B?RW1TWXIycGVOTjVPWWZvaTdkejB2Ri9Mc291V0hXczVzZkN2bG5zWmsyWEhZ?=
 =?utf-8?B?RUpqYzZjd0ZQZ0psZzdHdURtamRMdk5KMjJVN3hGSkFBYkZsTnIwK2ZkcHNs?=
 =?utf-8?B?NE8yMlMybXpwZmk3aXp4c2ZiZjZiMCt0YlZZZDFYNUxHUkFOZXdjVDAwRWtz?=
 =?utf-8?B?NUUrY0U1NHM5amNTeHNRZ3ZXM1lxbzJlUE5YZmZORlZ4T0VRdDE0S0ducXZ2?=
 =?utf-8?B?eS9RMkdsTDZROVpPWTcwTW83aEgzT2dDZzZySkw3dUJ1TDZXYUJhdk1NWk5E?=
 =?utf-8?B?cHRwN2NvejFDdFFqaTU0ak5qbmFKMEEyajdleEh0bkxROW1HTEEzR1JnTTFU?=
 =?utf-8?B?MGZZeVN4VW1ya1Z5ZW96VjVmcXFrQno4UXFtUVk3eG5rQ2lud2RjRmNranlr?=
 =?utf-8?B?UnkxTkdZU0IwNU9qdmk3VnF2N0l4WEFXalMzYkQ3d2hlSmljVit3RFF1bXJB?=
 =?utf-8?B?cnhaTTZaL2d2Q0l2clhScm8rRHF6cGh4YUZtRWZDSVAwd3dDTm52ZE9FUDYv?=
 =?utf-8?B?UnlWSyt0bWQ5dFJ6dlRkcGFnMExBOU1GT3A1M1NVbGhkcE9xcDFrZzh4d0FM?=
 =?utf-8?B?MWIzOHdVQ05VdnQrRDFUY2tseGxUbG5Nc2Zlb3VIZTNERFBwd2pMeExiRTNr?=
 =?utf-8?B?UGtSQmdSbGsveFB0NTMxV3p2Tjl1Z1dSUjBPbk9PVGdkMHYzdTBobnJnQTMy?=
 =?utf-8?B?RkhJSGZkZnZEQUIwU1k3Nk9jUVNoWERNRWwreDNvTDYxY1YyWVVzUFU3OFFm?=
 =?utf-8?B?ekYwM1R5ZXBmOHNmMDRDeEFhZ1kxditTYnBsYkNUcHBIOUgzeFRXSklvd21Z?=
 =?utf-8?B?WlZGWDIwMHl6MDlZVGpIWVhlL2VNQmZkSVMrMStNUEcxeFdLZDY5U0w3bzlr?=
 =?utf-8?B?b0JBeXZRYlZZNTFoRFlkcVNzRkpEYmVQWTdjcEJDT3NxbG01YUdrZXQ5ZzJs?=
 =?utf-8?B?VEFzT0J6eE1Oc1ExMDdPZ3NvdWJVV05XZSs5QVpOL2QvODVwS21xaHlHWUVX?=
 =?utf-8?B?S2QwL1NzOHlVaEFPZVB3M2RISEVwZ0pWK1Rad2svalZYUjB5eGcwdzVwM0x1?=
 =?utf-8?B?Uk9ZN0JtN0EwbzRHY2tod1Z1dkhnM29BUHVnT2Rxa212cW1weTFnaDd1eUVT?=
 =?utf-8?Q?eV+f2XVp/KZokLEqFKxXRD/x2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1DVjOh0fEEcR29zGN5odT4AN4q57rJuS19Vrf3HVco4ZDCxvy3edE1+pJlse9IfeVDhrmAW8fiSGWBHNSKMEi7yWUukA5ORzKS7WQm3QPIWpXrKHPldpFJlbHrhTYMmO4jmQjux6lyVcnl5t+vfL9RtXOV/9UJFjZvvOVDXB0NMZsmvIBOX4CawzJ+z8846boU90YkxoWGa6MYJbgACdvVTPGvBd24VLJ9DaLTEUL0/4Sak623x6dvgJjzlSOhwBchUXsKyegXES5awzjfoTtijc/HqfktOtvS0qr1WfOXClpte9QxWuDAWvVDyLGhR5OJGWHqAXrxxDkDz0KNM9HyLI9KQ9fFQ+BUYoehaRI2dqdsokZHH0YWYegOEKniTRLs4jpI2ASNZOk8hW7/3k+sS+f/4H5OkKkgvdkh2YztfkWsMzCAyNf++hgYuKt/SAFvkfMkPqpNRyi5L/h47ZIlilyaMNfvvAJ4LMiYy/cir/quptZ7FzyD1phP6bDJN1chrlUhNpL/QUumRUWE+k9soHY33jHVrQ6nmrUxIeK6jzBfsGeIO5C2VazMDot1QdnD02F+Mxvruc+S2Jom6qGPtX8snQRd+4lX/16nBIo9a7zjtwOj1SsOScETk38IQ3z/XlsaGJlYNMh6Lil+dYHTp0t6ON3divopu//XJD8USY6bqJjua9TIb0SHdGsSs84E23KWtwVCrcPui7q7N4Cgk2Rh1bH7r1q50XxiRDqsd3JgU47eQo2W/KSk1diYKe7HxQjhomUSq01k312rY5saGnwNPNayej6i/liPITsyXulRFn/FJbzjoUuSZ336GnTo+9QOnQvWAEwfLNUJZlOg0JsPwtFJqB2aDtKk5S5ffdNu6Ei1oDOqneX697Y5GgNRbP0a3Abs3NWQC4lfwg8g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ca74cf-da41-4de8-e558-08db3c4dcdfa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 18:35:07.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42bEnniqgyk+T7r+D/TLajQ7SKY4tj6SosC7gcKgX9RHw633rgxZdt9UaNppTJFX7jhadXjQ1ppBVCOEqoDoEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_13,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130165
X-Proofpoint-GUID: tJH2GxrVgxR3XgoTgH_NxHNuu6GGkiv4
X-Proofpoint-ORIG-GUID: tJH2GxrVgxR3XgoTgH_NxHNuu6GGkiv4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------09QsUMG0LHpV5CrA7OiAMb0v
Content-Type: multipart/mixed; boundary="------------9JAX7uwp7sefr36e61L1unDn";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Frank Filz <ffilzlnx@mindspring.com>, 'Jeff Layton' <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, bfields@fieldses.org,
 linux-nfs@vger.kernel.org, 'Frank Filz' <ffilz@redhat.com>
Message-ID: <c82e4b32-5df7-20c3-d0a8-4a30b9ae4482@oracle.com>
Subject: Re: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock
 request
References: <20230313112401.20488-1-jlayton@kernel.org>
 <20230313112401.20488-6-jlayton@kernel.org>
 <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>
In-Reply-To: <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>

--------------9JAX7uwp7sefr36e61L1unDn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Tm93IHRoYXQgSSBoYXZlIHNvbWUgcmVwbyBzcGFjZSAodGhhbmsgeW91IFRyb25kKSwgSSBh
bSBwdXR0aW5nIHRoaW5ncyANCnRvZ2V0aGVy4oCmDQoNCk9uIDEzLzAzLzIwMjMgNjo1MSBw
bSwgRnJhbmsgRmlseiB3cm90ZToNCj4gTG9va3MgZ29vZCB0byBtZSwgdGVzdGVkIGFnYWlu
c3QgR2FuZXNoYSBhbmQgdGhlIHVwZGF0ZWQgcGF0Y2ggcGFzc2VzLg0KDQpGcmFuaywgbWF5
IEkgYWRkIHlvdXIgVGVzdGVkLWJ5OiwgZm9yIDUvNSBwbGVhc2U/DQoNCmNoZWVycywNCmNh
bHVtLg0KDQoNCj4gDQo+IEZyYW5rDQo+IA0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IEplZmYgTGF5dG9uIFttYWlsdG86amxheXRvbkBrZXJuZWwub3JnXQ0K
Pj4gU2VudDogTW9uZGF5LCBNYXJjaCAxMywgMjAyMyA0OjI0IEFNDQo+PiBUbzogY2FsdW0u
bWFja2F5QG9yYWNsZS5jb20NCj4+IENjOiBiZmllbGRzQGZpZWxkc2VzLm9yZzsgZmZpbHps
bnhAbWluZHNwcmluZy5jb207DQo+IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmc7DQo+PiBG
cmFuayBGaWx6IDxmZmlsekByZWRoYXQuY29tPg0KPj4gU3ViamVjdDogW3B5bmZzIFBBVENI
IHYyIDUvNV0gTE9DSzI0OiBmaXggdGhlIGxvY2tfc2VxaWQgaW4gc2Vjb25kIGxvY2sNCj4g
cmVxdWVzdA0KPj4NCj4+IFRoaXMgdGVzdCBjdXJyZW50bHkgZmFpbHMgYWdhaW5zdCBMaW51
eCBuZnNkLCBidXQgSSB0aGluayBpdCdzIHRoZSB0ZXN0DQo+IHRoYXQncyB3cm9uZy4gSXQN
Cj4+IGJhc2ljYWxseSBkb2VzOg0KPj4NCj4+IG9wZW4gZm9yIHJlYWQNCj4+IHJlYWQgbG9j
aw0KPj4gdW5sb2NrDQo+PiBvcGVuIHVwZ3JhZGUNCj4+IHdyaXRlIGxvY2sNCj4+DQo+PiBU
aGUgd3JpdGUgbG9jayBhYm92ZSBpcyBzZW50IHdpdGggYSBsb2NrX3NlcWlkIG9mIDAsIHdo
aWNoIGlzIHdyb25nLg0KPj4gUkZDNzUzMC8xNi4xMC41IHNheXM6DQo+Pg0KPj4gICAgIG8g
IEluIHRoZSBjYXNlIGluIHdoaWNoIHRoZSBzdGF0ZSBoYXMgYmVlbiBjcmVhdGVkIGFuZCB0
aGUgW25ldw0KPj4gICAgICAgIGxvY2tvd25lcl0gYm9vbGVhbiBpcyB0cnVlLCB0aGUgc2Vy
dmVyIHJlamVjdHMgdGhlIHJlcXVlc3Qgd2l0aCB0aGUNCj4+ICAgICAgICBlcnJvciBORlM0
RVJSX0JBRF9TRVFJRC4gIFRoZSBvbmx5IGV4Y2VwdGlvbiBpcyB3aGVyZSB0aGVyZSBpcyBh
DQo+PiAgICAgICAgcmV0cmFuc21pc3Npb24gb2YgYSBwcmV2aW91cyByZXF1ZXN0IGluIHdo
aWNoIHRoZSBib29sZWFuIHdhcw0KPj4gICAgICAgIHRydWUuICBJbiB0aGlzIGNhc2UsIHRo
ZSBsb2NrX3NlcWlkIHdpbGwgbWF0Y2ggdGhlIG9yaWdpbmFsDQo+PiAgICAgICAgcmVxdWVz
dCwgYW5kIHRoZSByZXNwb25zZSB3aWxsIHJlZmxlY3QgdGhlIGZpbmFsIGNhc2UsIGJlbG93
Lg0KPj4NCj4+IFNpbmNlIHRoZSBhYm92ZSBpcyBub3QgYSByZXRyYW5zbWlzc2lvbiwga25m
c2QgaXMgY29ycmVjdCB0byByZWplY3QgdGhpcw0KPiBjYWxsLiBUaGlzDQo+PiBwYXRjaCBm
aXhlcyB0aGUgb3Blbl9zZXF1ZW5jZSBvYmplY3QgdG8gdHJhY2sgdGhlIGxvY2sgc2VxaWQg
YW5kIHNldCBpdA0KPiBjb3JyZWN0bHkNCj4+IGluIHRoZSBMT0NLIHJlcXVlc3QuDQo+Pg0K
Pj4gV2l0aCB0aGlzLCBMT0NLMjQgcGFzc2VzIGFnYWluc3Qga25mc2QuDQo+Pg0KPj4gQ2M6
IEZyYW5rIEZpbHogPGZmaWx6QHJlZGhhdC5jb20+DQo+PiBGaXhlczogNDI5OTMxNmZiMzU3
IChBZGQgTE9DSzI0IHRlc3QgY2FzZSB0byB0ZXN0IG9wZW4gdXByZ2FkZS9kb3duZ3JhZGUN
Cj4+IHNjZW5hcmlvKQ0KPj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4NCj4+IC0tLQ0KPj4gICBuZnM0LjAvc2VydmVydGVzdHMvc3RfbG9jay5w
eSB8IDYgKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbmZzNC4wL3NlcnZlcnRlc3RzL3N0
X2xvY2sucHkgYi9uZnM0LjAvc2VydmVydGVzdHMvc3RfbG9jay5weQ0KPiBpbmRleA0KPj4g
NDY4NjcyNDAzZmZlLi45ZDY1MGFiMDE3YjkgMTAwNjQ0DQo+PiAtLS0gYS9uZnM0LjAvc2Vy
dmVydGVzdHMvc3RfbG9jay5weQ0KPj4gKysrIGIvbmZzNC4wL3NlcnZlcnRlc3RzL3N0X2xv
Y2sucHkNCj4+IEBAIC04ODYsNiArODg2LDcgQEAgY2xhc3Mgb3Blbl9zZXF1ZW5jZToNCj4+
ICAgICAgICAgICBzZWxmLmNsaWVudCA9IGNsaWVudA0KPj4gICAgICAgICAgIHNlbGYub3du
ZXIgPSBvd25lcg0KPj4gICAgICAgICAgIHNlbGYubG9ja293bmVyID0gbG9ja293bmVyDQo+
PiArICAgICAgICBzZWxmLmxvY2tzZXFpZCA9IDANCj4+ICAgICAgIGRlZiBvcGVuKHNlbGYs
IGFjY2Vzcyk6DQo+PiAgICAgICAgICAgc2VsZi5maCwgc2VsZi5zdGF0ZWlkID0gc2VsZi5j
bGllbnQuY3JlYXRlX2NvbmZpcm0oc2VsZi5vd25lciwNCj4+ICAgCQkJCQkJYWNjZXNzPWFj
Y2VzcywNCj4+IEBAIC05MDAsMTQgKzkwMSwxNyBAQCBjbGFzcyBvcGVuX3NlcXVlbmNlOg0K
Pj4gICAgICAgICAgIHNlbGYuY2xpZW50LmNsb3NlX2ZpbGUoc2VsZi5vd25lciwgc2VsZi5m
aCwgc2VsZi5zdGF0ZWlkKQ0KPj4gICAgICAgZGVmIGxvY2soc2VsZiwgdHlwZSk6DQo+PiAg
ICAgICAgICAgcmVzID0gc2VsZi5jbGllbnQubG9ja19maWxlKHNlbGYub3duZXIsIHNlbGYu
ZmgsIHNlbGYuc3RhdGVpZCwNCj4+IC0gICAgICAgICAgICAgICAgICAgIHR5cGU9dHlwZSwg
bG9ja293bmVyPXNlbGYubG9ja293bmVyKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHR5cGU9dHlwZSwgbG9ja293bmVyPXNlbGYubG9ja293bmVyLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvY2tzZXFpZD1zZWxmLmxv
Y2tzZXFpZCkNCj4+ICAgICAgICAgICBjaGVjayhyZXMpDQo+PiAgICAgICAgICAgaWYgcmVz
LnN0YXR1cyA9PSBORlM0X09LOg0KPj4gICAgICAgICAgICAgICBzZWxmLmxvY2tzdGF0ZWlk
ID0gcmVzLmxvY2tpZA0KPj4gKyAgICAgICAgICAgIHNlbGYubG9ja3NlcWlkICs9IDENCj4+
ICAgICAgIGRlZiB1bmxvY2soc2VsZik6DQo+PiAgICAgICAgICAgcmVzID0gc2VsZi5jbGll
bnQudW5sb2NrX2ZpbGUoMSwgc2VsZi5maCwgc2VsZi5sb2Nrc3RhdGVpZCkNCj4+ICAgICAg
ICAgICBpZiByZXMuc3RhdHVzID09IE5GUzRfT0s6DQo+PiAgICAgICAgICAgICAgIHNlbGYu
bG9ja3N0YXRlaWQgPSByZXMubG9ja2lkDQo+PiArICAgICAgICAgICAgc2VsZi5sb2Nrc2Vx
aWQgKz0gMQ0KPj4NCj4+ICAgZGVmIHRlc3RPcGVuVXBncmFkZUxvY2sodCwgZW52KToNCj4+
ICAgICAgICIiIlRyeSBvcGVuLCBsb2NrLCBvcGVuLCBkb3duZ3JhZGUsIGNsb3NlDQo+PiAt
LQ0KPj4gMi4zOS4yDQo+IA0KDQo=

--------------9JAX7uwp7sefr36e61L1unDn--

--------------09QsUMG0LHpV5CrA7OiAMb0v
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmQ4S1YFAwAAAAAACgkQhSPvAG3BU+KV
zg//Xx40fyk4BJTv+xyfGL2mpQf+vKsrROdrqth8WKjAHsYnZbvcg8n+lkOvO9WvsOgG2spmZgkM
7P3yYPqUsH0Ny2oG3ioVTo7mv9Ji+cWk8GrZwF4xPInENcT6CPC+xSTv7smsRTc0VUO8qt6WlJae
OAkGj3saKs5FN1TDTrSE186cuVQSwmaCS4vHsbuIEAnBmdjFn7V/IGEYpL8j/6b3JTIcrD5O70H3
qYItr7Llc+54GnQCbsnu6U7E+AB0Q7QZbz4Kl/9+JCbwAAsCqT5+zFWpdukksUV+M9BK1GeCaJdM
lEe4ZrbGqe8HGKuQnwN0Q0igxCQcTB1cpvMm+RhfyFi5vFT09ZFeIVjE0jCeE5CCGK/e1MNAzDXO
rpTXa/dGINWAvPaOqOTLKnjfOBWuE0ZEwVzZYcf7GZzsTa8nCRJJMWkIMVWy0fW/J4pThF69qnO7
E49LZk6vpvnuy6zVOlUMMFGYmJWkvW6m12kJghhk/4Qps/PQz94o+HYnIEvcqOmzndpgEUdJJsOQ
lE9fht2vlRjBbm04CAXDAQ5K8RB3J0Dy/dzIpWAQPaIKTKKNNztYMJpqQh8EUMoUgweDcGrHBsAl
2Njp4LCsYZdiPbXPxlU7yI+xWhQz/0umN7hSOpBEixFFgR3P/5DSbjvJQryqPAHiQQnf1IOyZixn
xDU=
=/Cli
-----END PGP SIGNATURE-----

--------------09QsUMG0LHpV5CrA7OiAMb0v--
