Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A796B7DD4
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 17:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCMQkL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjCMQjt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 12:39:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07AF6A1F0
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 09:39:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DGYKsc018421;
        Mon, 13 Mar 2023 16:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=OBoIxWnTr9hQs9GSySVGkmJJfXDRSSMV7Codhb3GdsQ=;
 b=aA30NGgc0fvImjCFBFtfrrCVc5B9EjMn6Iq3H3SKlTdX+Dwo47CGY773mNH7czDSZWoi
 RthrXJ24NoBb+q694E+Ov7jpBOsRHdnVb2h9agAgI9jcIBftZWzvuJmXkX/mYMrltajk
 NgrZ2ROO3X1fI/DbzsVApsBtcD4315DnKYrx7KI0WlGyp7oVfhmkyc9lcKYJd3GhqhRP
 aGNUPsvuuZXIkGA2bgB1RFXoHNk4lm9q3H8dvEpMIw5xm0BG4TkUF9PP2d/BG4cEN2/k
 bVPrmyNZsfpeESW0HJkWdIN2AMxaCaYgpjHsFIsTpnSi9e3YdVVzRcjychA+62FcIYdI Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u4cg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 16:39:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DGZEsu008159;
        Mon, 13 Mar 2023 16:39:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34whyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 16:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnK3xShbEkYPk0Nbo+9yJoN8Nnh888PPZDIhKaPXE59lDbPYdQWfD2e6Utf+MI7xOpasYPQfF5KqjkzSEjFiwHbaIeTVd8orZppy0uMqLx23lL+3sR61cApls6pr7MTe0BeY3oGxzpHrofVYh3TqNFOFV5/+L9CSP2qCR0nmNkYInFkorwucSpCktnYzQvDFtpbriEOYj3C/Wrw9HIVNfHurJlpxy0TRoODFQ+JnYCwVPJOQknYN3LeYDRmry5gwdnT+8kW8ePEjzb6K3naskORLraQgITPZcb9HRK9AHhpregR0TJB+hWTtItulNzLNxrlrMWxmuEc07399pz5cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBoIxWnTr9hQs9GSySVGkmJJfXDRSSMV7Codhb3GdsQ=;
 b=Dehif0g6E4cS/lLS6l37pnW0jdgZ5DDtFeEDAHvf9j7JkM2SXqDfeQcxANwFAISWqWM23XsArWHsFEKWUKhs2KpRmpjybsnNY1nYbsJHKT17ubMYuNi/8y2xrFnZtJnKW007Jcxd10lBSE/Bp33vouSBpJJJQoEHoRznt3lzaMPljL2QeK4FKibL/mGHhUBTgztzwvsiQ9vSmZdXR1NamGBAuWb85vRocy2AnTx4lkfDbXtQXGB6e9icJiKzGHIa7N7DAKeZXry29PDdganGHkAJ/GspV0Jo0SfeCJgjbHxLskReb66rcW415VfVeABtFpdIHlLf9XPUi02FgxbHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBoIxWnTr9hQs9GSySVGkmJJfXDRSSMV7Codhb3GdsQ=;
 b=gyE21M+QW84n4zXqYJlEJ3MxRJGCkCCmjB3rHZkxUgAnw9OXBbGfL65SVihOPsEgmcWEgmtCkzKajfLjT3MsiOFm9tfmNmsYDdJOLvkz9uPk0HqcQTJ7wjCrDx61HQJfpcshnWS3aksAZ1wme7JiBQOAw3CzN88vSK0K9IO9zmw=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM4PR10MB6112.namprd10.prod.outlook.com (2603:10b6:8:b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Mon, 13 Mar 2023 16:39:19 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 16:39:19 +0000
Message-ID: <5d5b9df3-cbc6-c99d-d6cf-c676da2cd599@oracle.com>
Date:   Mon, 13 Mar 2023 16:39:14 +0000
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>, bfields@fieldses.org,
        ffilzlnx@mindspring.com, linux-nfs@vger.kernel.org
Subject: Re: [pynfs PATCH v2 0/5] An assortment of pynfs patches
Content-Language: en-GB
To:     Jeff Layton <jlayton@kernel.org>
References: <20230313112401.20488-1-jlayton@kernel.org>
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 gx3r8uLHNg==
Organization: Oracle
In-Reply-To: <20230313112401.20488-1-jlayton@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MML08MyO8qCS540pV8joYyZH"
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM4PR10MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: ec80674b-c852-4c55-e2ff-08db23e17dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIeTaG393JCr5eCBQvAefH+1dTAEfj3OuoEzYDQL6B1Fs6/NqBgUXYzgkxpkkSZlXrIoO2JVhgg19yh16ZzPeeOGUyY26xv8gj2mfkgCdowDucxEjHHNqGMpu0TacnpQ7nDVobOih85cdf4OWoNuUOeDfDV81eI468V+NF1t8648J48WPESkOUFAzSnURKOMVUTvnMKs6FsEfC9wcG1+sUxNjq7SMwSx7/HoximgO7Gf1NcJVHn2U/9z0KnEgkCVV34QtPKnQKGH8f5OnCSITuWtTCFbIuZTWU64YVOAHfEJibz6G6Qo/gM9bdtn4QAF/012CFWueqB3ht2f2/yUtjsPOkfO6/DyqTtO8Hjx/gUp7LYor5QXfMAfe+ScG0QPKct1sBJv9GvNN8lbeXZv1JnKJ1BWqEb3jreHMQ7ET0HaUJZ5taP0kw/j1UYkJ7UuJtBaRPXIS8O9UY2Ra27tpuGGeTmpQL6Jh3WiVOaUjOSB5TKzNC4QhEdOaUcGn71XsLLL4bAArBoK+FuXbU4G1/wu95g18ACxW4wBa5vVuINFiNCUsdqMqzuAAwLCPwFB4F87+/UPfi5IL5SyNLuFPJqsMZUIdo8eMg/f4Cyj5ZT0TlTxjaLqllRJcmMCEx81YvsO5Ss48KhUanzBeR9xYMCeNhpThEtAbQdqNJ+pJKnqr2mQRn29ApVYla9xzJfaBoXsoACdvEW6Os3gBdvDI3R8L12JjlvDhd6VWBu551Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199018)(36756003)(86362001)(31696002)(6916009)(33964004)(26005)(186003)(41300700001)(6506007)(21480400003)(6512007)(53546011)(5660300002)(235185007)(4326008)(2616005)(8936002)(36916002)(316002)(478600001)(8676002)(6666004)(66556008)(66476007)(66946007)(6486002)(38100700002)(2906002)(44832011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0JyUWlqYzI4bFAyQjFpa205eUpqY2Q3Vk9tOVVtN1IzWkdmcmtvdzNnaWxl?=
 =?utf-8?B?cEJkSHpOdS81dUtPUjhkNXdHMVA1OEVpc1k3VFJueTNTMTNCMk1zVk8veXc1?=
 =?utf-8?B?MUwwZ3FpR2toK0ZnSko5amtOTS8weFFCSnc5a1Bac3VYaXdaZlVjeEpPclI5?=
 =?utf-8?B?eDJFQzlJU0kyb2htaUFsRkh2MmltM1JPNU8zTHJDMzdJaTM5c1NzWERPSmJQ?=
 =?utf-8?B?ZEMzSlV6c25JK3l0K082aGhvV25sR3VWMzFKQ3FqYTNQZ2Irem9IemMxREF6?=
 =?utf-8?B?Wk9yc1p0c29IVEsxYnd5NFNKbENmZFJTNjZscVpDQThMa2FhYjVqWFJRMWxR?=
 =?utf-8?B?N2F5NUxEaU1Ld00zZENhNXBlaUhLejlaRC9pc3VNQlFOMUorYmJRWVcyUURh?=
 =?utf-8?B?ZzBsK3BKUlZRZ0N1K2FJbXMreWRic1JxRDMvYldWMDBPUGlzdHRiRFBHbFdE?=
 =?utf-8?B?RW5ZQ25sVEtLK095bCt3cWUvVTVjSWM4a1Z5ZTlFbjBoUGVpRFYwcWw1YlBq?=
 =?utf-8?B?c1QvdGpEWDBQMG1lYkxQYmg4UVNidUlsTEJ6QVNrNC9wNWM5OXdWOHpJVFk1?=
 =?utf-8?B?dndkQTMvYXBId1ZmU1Y1Zy8zU3ZoNmt2dGJpWmZXVWVtSFFyNWxBUjIyL3NC?=
 =?utf-8?B?L2dvZ3VtZ3dBbUlnZXlSQzlZd2E5OEc2T1UxVXB3eWNyZnVlYTVVc25xZk5l?=
 =?utf-8?B?UnhvS3U0NWd5Y2VUa0FQa1dGODk5c29CdnB5THlleXZyU3I5S081SUM4b2tl?=
 =?utf-8?B?SmhEVjRCUGVGVUt4aEVVYThqYno2WG0zZ1dYT1BhMHFUb2xuZ0JkVTZQUXRC?=
 =?utf-8?B?NUhzWkdjdGR2SkRiOWg5Y1VVdnRaM2cyMEVOK1Y4WDFVaU9oVkcxcTBtSjdv?=
 =?utf-8?B?dXRLczdZcTFEVkhhbDdZLytiNFU5N0Q5dG16bGlxVjBQbVN6RUhXUnZzeU5r?=
 =?utf-8?B?SC8rZS9OVzBxSUwycDZhV2N2MmQ3M0o3WHdQSTQrV3dobEhTbVlaNXMxU3Zm?=
 =?utf-8?B?U29Hc3UwSGhYUVhHUE9uQmZrZGtVdVV0NUVYZXVNUitWQ0Nvdm9KMlovN2Fz?=
 =?utf-8?B?eDRpRlZZK3NJaVJpNndQaXRXOFVOUU15a1NRTUl6cWNrQzNSd2N5VnZBQVZa?=
 =?utf-8?B?TnhyazdBeEZhbmNuazlyMVFiYmp2Y2VnZGpTd0JZREdkUFZsUEh0TERKcDQ0?=
 =?utf-8?B?TFFWRjZFOFJEdEdTZGk2YzZ5UHZnclY4YmFuMnhNME5DdmNBdDQ5SVZzTHRP?=
 =?utf-8?B?MmtjKzNXNUZmQldqejJpaUtuN3RjM29BdndRbmhLMFFIc3F0cTJJLy9NM0VK?=
 =?utf-8?B?dkRVM3V4MytoeFdjc2VKTGVIOUVlN2ppY24yNlc5azJDOFc0MW13c2cwbUNw?=
 =?utf-8?B?WHVXaS81bFh5Mk53Uzl2MjVlTXpPLzJsYks4alhZcXoxMHhSN2JCdGNFZkJZ?=
 =?utf-8?B?WngyZlQ4YldXa3pXYjdLSWhBWndKSVpaTG9yT2dHd0RtUVZsZnoxcmw5ZWd1?=
 =?utf-8?B?Z3NLQWRsejgzZ3JhM3VEY1lJVnlZZmpJOWJ5aTRVbEpzYzBOSnFUU3VRaXR4?=
 =?utf-8?B?eTFDQS85NUNaSTVsaGpVR0VWV1JCb0xtVldERmRpckdIZ0p4cml6eFdtUHJy?=
 =?utf-8?B?RUtxa3BxQ2xhazQzNmN5RDRvdnpVVjJtZW1RdXFBN0Y2S1VRMVBuRkM5aWUy?=
 =?utf-8?B?UE1pNnAwVFlxRVg0NUdIT0k4c2hKSE5zTlpCY1oyZHpIZ29nYURtNkVmODlu?=
 =?utf-8?B?bGUrMXppWjQ4UHJwdlFxdkRZMjdOOHRlUCs2WU5HakY3UlVUL3VWenZjb012?=
 =?utf-8?B?WkVqclFDaXRnUDg1eEhVQ1RpNHhzUGNJZXNtM1N2bjc2UHR4eFl6RG15bDFj?=
 =?utf-8?B?Vm9SbVJpMU1TeEF4ZXhtK29LR0R4MmhVbUF3NkU2eXJTdXNrNE9od0tackZr?=
 =?utf-8?B?RDQyLytDdDlSL0RhS0V5WUpmeDl6VkRHYlU0QlkvN0xVdVB0UkpsSzhGOXJ1?=
 =?utf-8?B?SlJZbTlQVjFlR0ZNc21qakJ0dnNOYldyQXpXNVVLWHhhM0JJSVFQLzhpeGtK?=
 =?utf-8?B?aW9tWFZSRXJlV1E3enVxWVBvZFRaRUNHZTFvYzZrbUFxeEN3VE9vdzliQS94?=
 =?utf-8?B?L0pESWI1RDdpSUVkMnNuaWJBRW84eitGNXpmSmtXSjBuWloyUDlYNitHUCs4?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iWDD+HRrK75+BfcKpFK9F7eLcq2kn35jQ4SRSzbVwAQaxWocZMZ5p/kN5GXyIKFRSrshTYfiapHhlu2bwFk23BewBsvmQ7CsvvC+qrFODJ0HmQyfcLI4gti4Izs01qjwY/28ZB30jHwMkaviH1zyhPX1C8Fho8kf6R6BSQt0Cx8bQs+dcM/M/cCFB4NJpC/PtTbNCktJI/Ah+BheFD+8uuu1+BT3ZHgjtPJSl2v8Ka/7bnyjq3XwvpaS8Nn/W4KDuIi3dgJFvLYJplKuFgWz9wteDSK7tG/oCKmO9J4PQq6itmUO4WOyPuRw5NMY2QwxWU/3FZfL3CNKs6y2L/if9KkMlSN7uaCmgPqrHLBEorxmP/NFCdjkq4XUabEKh0WirZP/MsoLHyY5VII0rbsN+7ZQguMQkN/lSVCvsnh5ZtUrVIDhnf4/Kyq3q45Od9FxzUn2meED/1Lbj8m+konpW54LEfy1OiBg3M2lcQty4abyWlWGTo1bXY6FtDwvfrRZzWTBoEeoA10BcLdmDTe3XFAoKt3QZvOnjqK2HqiqvsGV0BXGkjDmSOdC84jPe32UarIAMux+8L+A2TaWDgYJ+wy/JUMgI2Y5smh3yHMMdxDPRU052Y1ozYRM3M2juscEElAY3abtyEuvlxhG0MW3crd6/rNaitPClMAVAGwqnD2/+mRwLyf8Yu9+2cvSJgC6tkP0z3yzRqq9IvkEBEllRG7rmemCIsB9xgc1iw2dQgIRrv2y32AJ9DzqQqkoo52ZE2mxNfjBcyMHbMvufYYAyoCZnhBTxe9DN08ecYHc8yo1UIxTXfVcNHdq4ru6SPYrixIwIKYD3rGou9c6F8+g4+jB3lSmxhYZvpFmJv/WVg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec80674b-c852-4c55-e2ff-08db23e17dbf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 16:39:18.9429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmhiM888AA9jhxyEZxwmHURZMS5NF0Ip+gaqVXOByv+Xjtd7ntMh11t5dYP5ISI50hKKaAUZeCuUZYt5P8lgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_07,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=915 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130129
X-Proofpoint-GUID: 1CcWiMADg0G2eTIBo8EMNAza2MovUAPk
X-Proofpoint-ORIG-GUID: 1CcWiMADg0G2eTIBo8EMNAza2MovUAPk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------MML08MyO8qCS540pV8joYyZH
Content-Type: multipart/mixed; boundary="------------DbFbTcH5Z7ojTqsaULCM3kQr";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, bfields@fieldses.org,
 ffilzlnx@mindspring.com, linux-nfs@vger.kernel.org
Message-ID: <5d5b9df3-cbc6-c99d-d6cf-c676da2cd599@oracle.com>
Subject: Re: [pynfs PATCH v2 0/5] An assortment of pynfs patches
References: <20230313112401.20488-1-jlayton@kernel.org>
In-Reply-To: <20230313112401.20488-1-jlayton@kernel.org>

--------------DbFbTcH5Z7ojTqsaULCM3kQr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMvMDMvMjAyMyAxMToyMyBhbSwgSmVmZiBMYXl0b24gd3JvdGU6DQo+IHYyOg0KPiAt
IGluc3RlYWQgb2YgY2hhbmdpbmcgdGhlIG1lYW5pbmcgb2YgdGhlICJhbGwiIGZsYWcsIGFk
ZCBhIG5ldw0KPiAgICAiZXZlcnl0aGluZyIgZmxhZy4NCj4gLSBhZGQgcGF0Y2ggdG8gZml4
IExPQ0syNA0KPiANCj4gSSBzZW50IHNvbWUgb2YgdGhlc2UgYSBjb3VwbGUgb2Ygd2Vla3Mg
YWdvLCBidXQgZGlkbid0IENjIENhbHVtICh0aGUgbmV3DQo+IG1haW50YWluZXIpIGFuZCBh
IGNvdXBsZSBvZiB0aGVtIG5lZWRlZCBzb21lIGNoYW5nZXMuIFRoaXMgc2V0IHNob3VsZA0K
PiBhZGRyZXNzIHRoZSBjb25jZXJucyBhYm91dCBjaGFuZ2luZyB0aGUgbWVhbmluZyBvZiAi
YWxsIiBhbmQgYWRkcyBhDQo+IG5ldyBwYXRjaCB0aGF0IGZpeGVzIExPQ0syNCBvbiBrbmZz
ZC4NCg0KVGhhbmtzIHZlcnkgbXVjaCwgSmVmZi4NCg0KSSBkb24ndCBoYXZlIG15IHJlcG8g
c2V0LXVwIHlldCwgYnV0IGhvcGVmdWxseSBzb29uLCBhbmQgd2lsbCBnZXQgdG8gDQp0aGVz
ZSAoYW5kIG90aGVycykgYXNhcC4NCg0KY2hlZXJzLA0KY2FsdW0uDQoNCj4gDQo+IEplZmYg
TGF5dG9uICg1KToNCj4gICAgbmZzNC4wOiBhZGQgYSByZXRyeSBsb29wIG9uIE5GUzRFUlJf
REVMQVkgdG8gY29tcG91bmQgZnVuY3Rpb24NCj4gICAgZXhhbXBsZXM6IGFkZCBhIG5ldyBl
eGFtcGxlIGxvY2FsaG9zdF9oZWxwZXIuc2ggc2NyaXB0DQo+ICAgIG5mczQuMC90ZXN0c2Vy
dmVyLnB5OiBkb24ndCByZXR1cm4gYW4gZXJyb3Igd2hlbiB0ZXN0cyBmYWlsDQo+ICAgIHRl
c3RzZXJ2ZXIucHk6IGFkZCBhIG5ldyAoc3BlY2lhbCkgImV2ZXJ5dGhpbmciIGZsYWcNCj4g
ICAgTE9DSzI0OiBmaXggdGhlIGxvY2tfc2VxaWQgaW4gc2Vjb25kIGxvY2sgcmVxdWVzdA0K
PiANCj4gICBleGFtcGxlcy9sb2NhbGhvc3RfaGVscGVyLnNoICB8IDI5ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAgbmZzNC4wL25mczRsaWIucHkgICAgICAgICAgICAg
fCAyMSArKysrKysrKysrKysrKystLS0tLS0NCj4gICBuZnM0LjAvc2VydmVydGVzdHMvc3Rf
bG9jay5weSB8ICA2ICsrKysrLQ0KPiAgIG5mczQuMC90ZXN0c2VydmVyLnB5ICAgICAgICAg
IHwgIDIgLS0NCj4gICBuZnM0LjEvdGVzdG1vZC5weSAgICAgICAgICAgICB8ICAyICsrDQo+
ICAgNSBmaWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSBleGFtcGxlcy9sb2NhbGhvc3RfaGVscGVyLnNoDQo+
IA0KDQoNCg==

--------------DbFbTcH5Z7ojTqsaULCM3kQr--

--------------MML08MyO8qCS540pV8joYyZH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmQPUbIFAwAAAAAACgkQhSPvAG3BU+Kv
0Q//UO6XIDJzjX6uZyEuHpUDBWpyNfoCRmGHlWJ12dzRFp7DAyJlF+ZN6ZHgwDq1+0Vt1NlJzVI6
6fe+0dc8xvdf8HmehJZzJBC9Mp/iQLMB9CX+Z7dM7taufevx1YDOg0w0tC1hrfj7zNlcLwG1htxw
xwFxu29Rr9S+qlRWBcpwq52rbXMPhuar/vqjxd4bmFcB4wBPLLoZ1hiD5wQOcb0Dhn4k9FOnIsad
uPVrO2dbfnNoFqHAhgow0uzlVqceH//zSLcU6nECoQwvmUbt6gdXZoYiDzK4OPdk0D/pZKuOOcQe
4ym7DkVuTIl/+HhrFfQMI3GXx4jSbsoghhjl4LkM6zpv2q9JUw/u6N9bXEB4RXg6OC+1xO6VcD2W
lbFFSzCHBtenMqnzhhLE4Hm9WXAb7/NSWb3CQLLTJSNaTQc0N8PwjStK/uKrX9CfV/vo+0dNh3Y7
lNywW6Wxlh7qk6M9bM+soOBlDax0+/LJwR9ZI39mrLtGlT+TstN1dUZyGKU9lRMeoey42ceCvmC5
/IjGWmdHSb+lpBhS2QevhKUa+xqA5R8JzfWPjfWfZet7WyQp/4dKyCXnHmUCvIJcOF3lDLudAWwi
FuEzxGwDqjpDVmSqoMzciFedH6vom5aSkDuZVfGPZOKugNy4mQq7njoBB06aXyXzwI81f3+wQJPL
Df0=
=420T
-----END PGP SIGNATURE-----

--------------MML08MyO8qCS540pV8joYyZH--
