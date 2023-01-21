Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03176676824
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jan 2023 19:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjAUS5D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUS5C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 13:57:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B52D4A
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 10:57:00 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LE6BWE022080;
        Sat, 21 Jan 2023 18:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zMFJp6+TH1m1WEQ4T8w6Xa/GMmXUiCSicZl4aF5+TKc=;
 b=EuiH1WqDhlM3T/f0vM9M3LZTMry6aj+2/bICagcexmILJfPdNa1Rk2hQ/7iI+ZdDL4y/
 P3xuXB7++Iu7ME/QicTVhXYbV3egQoYKpLt9Q3YZkC7I8OVd38qUFFvWz8U7rURDhTi4
 iSY5g+S+rq6ZXrMkWhWA9vFHD5qK9oDruJCGOzszxQWLchCI06Tztlxts8WljdlcA5LN
 KKQCgCx+TjZB4HwSynpPaTjA69dxI9RHOK1gdv2dDSsaOLq5Kx4/VvpTWe7NFblya10R
 b6cLLczx872tec1SULeYkaNrwXzWBAFQgqnG24ro0FDYSjOg/TbbY6VCSxHqm+XBzhzD pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0rqav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 18:56:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30LIXsjX034291;
        Sat, 21 Jan 2023 18:56:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g21b54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 18:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbK1RPK3oIMq1+L5VXP3g4xSaYESoBkz9QQEqQT1QmKc2/8PGF4W5EadmecEoEJlumB097nmzrVDOlMNH3jMB+UzMYKM6n5N3RFh98cMYN6O4QskNmcBjPqM+RxO15Nk54ijV7x4V+3/+aVWROV15XwPqw0qZDE7dWkucrUgKHyoAoZz+Cql6js99J3WCGo1FPOkeBIudyv9mqV9Y5kSnkwi/MpebOCqcVCj5S8M5FAfAw4IRMatizuC8J8YjqVvYO4KYNYZ8LTxSp5rAuUJhZ7ZXj/iGQaypD8R27yH/0kktdjZawE8+beTIqGLcnJeE9OF7TCv/8rIlEenZlov6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMFJp6+TH1m1WEQ4T8w6Xa/GMmXUiCSicZl4aF5+TKc=;
 b=bMWG2hfyDpuwqwBxjh4Qamm78zpBMZ0GFi2gC/k17BhyPwk43zU94FbQ7GGaGlry4OOpPZLcVpKfztUMU3O0FIlwhsHbSRmDHv2PG/pj9zbcKMOByPCRwNlnN89YWSxHdQv+/9ARPtSDW6kV0LZxspIRyZadVsjHjMPVK0qE4WlaLWvI/CZEEifC5J3cZqy0zjLrZOmUeIm1gttHMkBI5OvfJfeeTfjZrIbhokJbfMy2zxZsNV/r+uhi4U3+llnzgKQ6CCswiXf9xTrDQbUOSr8J76KNWrXuxqOL2zuEGoIJFDkFWusmmRVBsZCpfpo8z2yYxMndHpTst1fTf90z5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMFJp6+TH1m1WEQ4T8w6Xa/GMmXUiCSicZl4aF5+TKc=;
 b=mHD0Su5NS1L+sjq/LWWco0/+jH+jBuFeTvovDeiudabfeQcfzJIBq/tSK+3nsvO+232PH9A3dUeNWLpQdzkMD7/dw4JsZaIqNfEfeRy4/LymnnBgtI+06PCtFBea1E54Yz/C3ZUd9u77ojT3YDJu/7VLCHmJVBELdILS7AbkoYI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB4986.namprd10.prod.outlook.com (2603:10b6:610:c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.9; Sat, 21 Jan
 2023 18:56:41 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6043.009; Sat, 21 Jan 2023
 18:56:41 +0000
Message-ID: <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
Date:   Sat, 21 Jan 2023 10:56:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, aglo@umich.edu
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
 <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
 <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
 <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:5:134::38) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH0PR10MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ba5762-b8b6-4c65-5cbb-08dafbe13b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGJZBEVxSnD2CGNmmRFNBwKcWkpvZtz7svHXzWmnCiyff2LjgadKqUPpGZQQyVtU9T/BI2TT4vuf8iMqQ7YuoQF//dzrvFCvoOr4ay75FqSTDOBS2699+OzwYA1P8snc3dU/vHOeta0j6nZ2BQ5ng3sPOuHSV7l3poczEhN1CyT/mHQH8p+G+M18yE5vD/m+JSAY3IwshDeFeuBgqNKbjZvdSuIe/0nRKvdGDtlN3VfOA9nGb26jgUYA2LdIC/nyQwersEWK4V6jV5O1P67itwpfh1I5XtLW+DRAxJC8C0vvtAi/yly5ucp/VZZHiLYJ3fGryRKwxgUWpgJ0eAMAEBQ/FHNz1+cXUUhu1bnLm0EArN0tFa59+PZyBCwzSVs9JqupJN2JRS4HCxBeEqFV2aVmWF4wg1FyjAxpPqJ0NnnCUorf5u5AdLruncjMAeO4wjIKkrFzAg4W8IaYyX25VAd5wmfFG2uCxr35vRpx/g0037eTLW1yoKHaK9NzJmMEDlhRptfHj0G1HkQ7DROFz6NEEZBXNZjU8+hgAXarWbVwBU2Dizbe2QdK77T1nOTLnc+PPZ0fCUXis36q0zJtvondTCSDOIpNt5qtgAv9VsoQL0xsFPGeZf0KKAKIJWc7E7IlTzq1edHpQGuDds+K0B7V7kj0gIB8HnOEx7MC3GZRkSVxZRGD3JmnZU0hbPCL+eJLZ8bqTXI+e2cNcNczZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(36756003)(2616005)(66946007)(66556008)(66476007)(316002)(8676002)(2906002)(31696002)(5660300002)(4326008)(83380400001)(31686004)(26005)(53546011)(6506007)(6486002)(9686003)(6666004)(6512007)(186003)(478600001)(41300700001)(38100700002)(86362001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVxMEFyVHBabDlYYlRoWHFLS05ZVzEzWVN0Q1JuWE55MXB3ejRYVjgwalJC?=
 =?utf-8?B?NzhJTitNTHJvNlZ0UWljdE1HYzZ6eHFXb3lQTm14MDJPOExFVXNtWUpZclpz?=
 =?utf-8?B?WkE1VTJmcnVpSGl6VEthM1hUd0NZbDBnRTJJYlZtTkRRbU41TzBlV2wySXdz?=
 =?utf-8?B?aDE2WFNkelQ4OW83UlZYQWhLN2l5RjB4dkMzUFVaNjNxZzU2WVZlV3pnREZZ?=
 =?utf-8?B?OWNOUGo1RDJ0ZkN0MGYvTEd5emRpeHAydEhMSlZ5b0N6V3ZlMXUxZnllRFVm?=
 =?utf-8?B?RW52YjJUbk9ncy9SZWZJRDNSMlgvdnFSOWZDOWVMK0VWYkJIOTMydXpKN3p4?=
 =?utf-8?B?QVd6ek95UkJnUzZvK2VyVmltNCs2S2lGb2dZaXVUT29pWU01S0M0YWNWZmlK?=
 =?utf-8?B?MTRNS3BlZ2xJUXdsZVNoSHR5TFBwYmNFSGt6Z3VIbmcvd2NyWFdkWmNOMGQv?=
 =?utf-8?B?UnUxZ2ljTTlvdFMvd29ESUZaYk96QzRPd0ZvWU1oaUlsRHpzajlieVVOQWQ2?=
 =?utf-8?B?Q0VWcmZLSU80Y1pPeUUvUEY2aTVWU3lSKzNDa2NzMEJ4SDlxcW8rbVNITzdO?=
 =?utf-8?B?U253VDNROWJvY1B3dkZWWlpRYy9ob29Fd3daSDRYdXV0a1gxT1E0RldSbWVq?=
 =?utf-8?B?alFhc01jQVZZRDJlZjVVTEtTdjUzVzdTSzFIQkpIbjQ1bXNEcnVDSUg5a0c0?=
 =?utf-8?B?bFkrZklFRmc4eThHSHltOGxuemxqcWE5cjk2MEJXL0s5SDFSOHNnTTFFWUpv?=
 =?utf-8?B?aTlJZE9xNE5DczJsVWRyU1NWSDUvMzNvQTg2Rks3alI3QThBY3U3d2hES0Qx?=
 =?utf-8?B?Q3dnMWpxVVNOaEk0NzZTMFY4MzVRam9tMXRzbHRaYktXQWNrVUZNUUMyS20r?=
 =?utf-8?B?WmtCUGwzNUZKOGg1dGJ6NEtwVWM4UEU1ZWFmREVzWDdWLzllVnNySUtvYjB1?=
 =?utf-8?B?bmJsbnJuUm00MGhzRm1XVUNWQjlEQ1ROUkk4OEIvZmthRXJNRXM1NzJveXdM?=
 =?utf-8?B?Y3dIODhqNlpKN1dqN1lRUzEvOWpWaUFCcGg0cGpmQ2NLK1dVSUJaYlUzVVVn?=
 =?utf-8?B?M3RDTVUzc2hJVExkdmJTdDUycllGZFBzcitSckxEcGtKQ1dzM0FMaDhDMkJB?=
 =?utf-8?B?bmpRY3lPZ055VUp5WTZiem1lVVlvcUM1QURWUytjaUZtS0o5czFudU5EcmN1?=
 =?utf-8?B?RU9zaWdLZ0V1M09aMmtVdkN5L21VcHlaVnVmS3BOTDdWbENCZjFFM1FsUjFZ?=
 =?utf-8?B?a0JpdTh3WFNjRmhaQkpnYlhxa3BObHI3WEZ1UlZrYXRaaW4rMy9kSksrbURZ?=
 =?utf-8?B?eWgzWVNkS2hSb0hMQzVTcFViRmc3Z2lOYUMrWVNiMkFFOXZHSklDZDhaWEZq?=
 =?utf-8?B?TG9SZUFKQWlXQU5rYXFuMUcwSjYwZUEzVFdFVWhIOElacytyMFZHVUNqZkZ6?=
 =?utf-8?B?NWNpK2FIaCtXUVRzamdYWlgyVTFjYUZ5bCs1MDk0dUtnSWQ0WVBwVlNPcWUr?=
 =?utf-8?B?dWxSblZ5eVh5elJUQUVqOUk0Vy9WSUlyK0lZL0VsczVsYVlBZFBDRWhIZmVo?=
 =?utf-8?B?SEJNcENXWTRKVE80KytJcHN5N213UE43UzJ5cHNTU203NkY1djMvT0NMY3dQ?=
 =?utf-8?B?SDM5RFkycVEwcnB2bEQ2SGZ0QnNBelZETXRrekpKVWUrMkhPOE9WdFk4SHRw?=
 =?utf-8?B?TGtYZzRkN2dGNFFsd1BiR0dXc3I1WG91NnNURGY5aEJUSTJic3k3WWxQVExB?=
 =?utf-8?B?MU53U1pNVDlMYTVPL1VHM003enVFRGlXcXZScTR6RTZsNUJsRmxSNXZLbm1h?=
 =?utf-8?B?dlNCVkdLeUZxK0k0UVI1UHRMYlc0RlI1VE5wZVdiN0owa2tiZ0R2am9nTlMz?=
 =?utf-8?B?aFJsVTZrQ3p2NnBGb05LV3pMZkJldllITE9YWTNjRjRybXVvenV4Nk16akFy?=
 =?utf-8?B?TllJK3hIb01BbzlYUTAvR0ZvZ1ErZ2ZkWFdPQlBHWmNvTzdmYjRLWjk0ZFJq?=
 =?utf-8?B?WVJnTjlXMWdrOGZLUFZLV2ZxSkxOMlhLV0J3b0lGaDBZWm95Q3Q1ZW1jdGc5?=
 =?utf-8?B?dWhOdFU5OE0wTWlPS0dIb2xJdzlOYmxKTWxkQXMwUnlHZjZRVmI2cXA1eVVB?=
 =?utf-8?Q?eclmkE47NeqY2mjiguwqYA2gW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YZwEJmo9n66WwSvMgEvab5drWyaPxWp+IZRux0cKA9ETEwFL8yenu74FceadthX29FnQZsHiQMtrxwVoaObUIQfA/MnhFjiGLte1RTIIs5Sz+33mmMJes74klCYIbJ3kfMygHqtrNhdd64405fcCwrY5RKFK3Dacr7OAaKaE+hItrjQs4DgQo9DrxJo0kARPdMM4D4UeN/ZSkjt2nhEmhke72eWWZ3O97jdCtOpds/siNxqyhPaheUYFigcllRXDLhdBhfIi7mriDGh/hnHG7RzkNbYbrYcryBQ6tMexu8ofdBx3KApomHz6egxU80qvHRRgQmOgSTmIT2ToM6ZUfpAfg1afloTGo5dV7Uo/qkmoNKkyKdj2dm1U3jlQ94vz3nybZTlGCZlTCh3eH2y3gL15XsD8T69V2g6tXkOVZtjitL1QEOQ17g9iMYMQfvW6XRSMoUh/b6NmtVb30V7FapKHY/YCsExFwUJTy1FOd5G2ODnfIdAYyo9MjiuOIbj9L6rnIS+hVff7bHK2Gk3WjTuPk0MignP8EPkbL4++hXJj61MOToqDyn2JE/IU6WM0AvlQ0KKm5mdXAZ2bE83Nzgguxv3nbybNtzNwlvhuPoNgYvR27xGZ/w8QlWV1rsxb5foRDRAA72CQ34r9ukeWHiUijPjAZ02UI3RQC/ca6vsBwaJnvIYwSfCRNThEjm39D8PqJa9TaV1zi3FNWcklgsM5sFvITsfy5bzx9ySxw17EDAr6Vrhx51mOgq8UGR0QXjjFCeW79qChCz3j5j6WXJVPJ77UtYSIgcj8giJ7SgowiDiJ/T485PStPwQK0hky
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ba5762-b8b6-4c65-5cbb-08dafbe13b75
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 18:56:41.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h98X5gmDaYPMndWjbdphSBdExGMUCFJMV7V4jEqsSn01/FSAL9J8L1JMeUPAK38NTPsA8ej83EILEKhkmythZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_12,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210183
X-Proofpoint-GUID: y95VIulVbI2D8__r82TbnK1NNkunRwjo
X-Proofpoint-ORIG-GUID: y95VIulVbI2D8__r82TbnK1NNkunRwjo
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/20/23 3:43 AM, Jeff Layton wrote:
> On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
>> On 1/19/23 2:56 AM, Jeff Layton wrote:
>>> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
>>>> On 1/17/23 11:38 AM, Jeff Layton wrote:
>>>>> There are two different flavors of the nfsd4_copy struct. One is
>>>>> embedded in the compound and is used directly in synchronous copies. The
>>>>> other is dynamically allocated, refcounted and tracked in the client
>>>>> struture. For the embedded one, the cleanup just involves releasing any
>>>>> nfsd_files held on its behalf. For the async one, the cleanup is a bit
>>>>> more involved, and we need to dequeue it from lists, unhash it, etc.
>>>>>
>>>>> There is at least one potential refcount leak in this code now. If the
>>>>> kthread_create call fails, then both the src and dst nfsd_files in the
>>>>> original nfsd4_copy object are leaked.
>>>>>
>>>>> The cleanup in this codepath is also sort of weird. In the async copy
>>>>> case, we'll have up to four nfsd_file references (src and dst for both
>>>>> flavors of copy structure). They are both put at the end of
>>>>> nfsd4_do_async_copy, even though the ones held on behalf of the embedded
>>>>> one outlive that structure.
>>>>>
>>>>> Change it so that we always clean up the nfsd_file refs held by the
>>>>> embedded copy structure before nfsd4_copy returns. Rework
>>>>> cleanup_async_copy to handle both inter and intra copies. Eliminate
>>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>>     fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>>>>>     1 file changed, 10 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>     	long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>>     
>>>>>     	nfs42_ssc_close(filp);
>>>>> -	nfsd_file_put(dst);
>>>> I think we still need this, in addition to release_copy_files called
>>>> from cleanup_async_copy. For async inter-copy, there are 2 reference
>>>> count added to the destination file, one from nfsd4_setup_inter_ssc
>>>> and the other one from dup_copy_fields. The above nfsd_file_put is for
>>>> the count added by dup_copy_fields.
>>>>
>>> With this patch, the references held by the original copy structure are
>>> put by the call to release_copy_files at the end of nfsd4_copy. That
>>> means that the kthread task is only responsible for putting the
>>> references held by the (kmalloc'ed) async_copy structure. So, I think
>>> this gets the nfsd_file refcounting right.
>> Yes, I see. One refcount is decremented by release_copy_files at end
>> of nfsd4_copy and another is decremented by release_copy_files in
>> cleanup_async_copy.
>>
>>>
>>>>>     	fput(filp);
>>>>>     
>>>>>     	spin_lock(&nn->nfsd_ssc_lock);
>>>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
>>>>>     				 &copy->nf_dst);
>>>>>     }
>>>>>     
>>>>> -static void
>>>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
>>>>> -{
>>>>> -	nfsd_file_put(src);
>>>>> -	nfsd_file_put(dst);
>>>>> -}
>>>>> -
>>>>>     static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
>>>>>     {
>>>>>     	struct nfsd4_cb_offload *cbo =
>>>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>     	dst->ss_nsui = src->ss_nsui;
>>>>>     }
>>>>>     
>>>>> +static void release_copy_files(struct nfsd4_copy *copy)
>>>>> +{
>>>>> +	if (copy->nf_src)
>>>>> +		nfsd_file_put(copy->nf_src);
>>>>> +	if (copy->nf_dst)
>>>>> +		nfsd_file_put(copy->nf_dst);
>>>>> +}
>>>>> +
>>>>>     static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>     {
>>>>>     	nfs4_free_copy_state(copy);
>>>>> -	nfsd_file_put(copy->nf_dst);
>>>>> -	if (!nfsd4_ssc_is_inter(copy))
>>>>> -		nfsd_file_put(copy->nf_src);
>>>>> +	release_copy_files(copy);
>>>>>     	spin_lock(&copy->cp_clp->async_lock);
>>>>>     	list_del(&copy->copies);
>>>>>     	spin_unlock(&copy->cp_clp->async_lock);
>>>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>>>>>     	} else {
>>>>>     		nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>     				       copy->nf_dst->nf_file, false);
>>>>> -		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>     	}
>>>>>     
>>>>>     do_callback:
>>>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>     	} else {
>>>>>     		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>     				       copy->nf_dst->nf_file, true);
>>>>> -		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>     	}
>>>>>     out:
>>>>> +	release_copy_files(copy);
>>>>>     	return status;
>>>>>     out_err:
>>>> This is unrelated to the reference count issue.
>>>>
>>>> Here if this is an inter-copy then we need to decrement the reference
>>>> count of the nfsd4_ssc_umount_item so that the vfsmount can be unmounted
>>>> later.
>>>>
>>> Oh, I think I see what you mean. Maybe something like the (untested)
>>> patch below on top of the original patch would fix that?
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index c9057462b973..7475c593553c 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>           struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>>>           long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>    
>>> -       nfs42_ssc_close(filp);
>>> -       fput(filp);
>>> +       if (filp) {
>>> +               nfs42_ssc_close(filp);
>>> +               fput(filp);
>>> +       }
>>>    
>>>           spin_lock(&nn->nfsd_ssc_lo
>>>           list_del(&nsui->nsui_list);
>>> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>           release_copy_files(copy);
>>>           return status;
>>>    out_err:
>>> -       if (async_copy)
>>> +       if (async_copy) {
>>>                   cleanup_async_copy(async_copy);
>>> +               if (nfsd4_ssc_is_inter(async_copy))
>> We don't need to call nfsd4_cleanup_inter_ssc since the thread
>> nfsd4_do_async_copy has not started yet so the file is not opened.
>> We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unless
>> you want to change nfsd4_cleanup_inter_ssc to detect this error
>> condition and only decrement the reference count.
>>
> Oh yeah, and this would break anyway since the nsui_list head is not
> being initialized. Dai, would you mind spinning up a patch for this
> since you're more familiar with the cleanup here?

Will do. My patch will only fix the unmount issue. Your patch does
the clean up potential nfsd_file refcount leaks in COPY codepath.

Thanks,
-Dai

>
