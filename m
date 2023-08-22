Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68DB784ADC
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 21:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHVTwH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 15:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHVTwH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 15:52:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8E1CCB
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 12:52:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MI6VoB002308;
        Tue, 22 Aug 2023 19:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/zumsIYvpmqGnJEX7i6w3hdYB1AAH+V+4tOsaB54OXo=;
 b=ZyUXNZGvHIA6emMoMRmkdTnhpxqby5zhazzbWzu0MXSqauTZA73xsizsboYwDNgfSz6C
 NxOw2WiU8uUWhZUiGEONPBR/mSfPNJPJQ4sL2zcC23qPVAjy6Pe4DTEV0/SxV8/pSeUA
 7rNYPQp3E/FIU+83eScvvG0bCQc4C5w22a9MtMNPavZAwpvApKqeUjM4hTxotuJu3+lj
 HAtDHfOv40MI32DIFY5j/BjbeCZGFrU0d+DCxgR9Do5Zm7Z3kTpVEWsPTKtfF5xwPfnq
 J2t1SbiodmNF3q+5m0Ph+BYNxaQWzPHU2Rn8NHt4XNJJ4dcMnxhl8hubPF/ccBuABN/O 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20d87ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 19:51:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37MJndtO000930;
        Tue, 22 Aug 2023 19:51:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yr40v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 19:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj482dxYWza5kiYUW/Puuz5lzDU+rzbcwWcdUjZbKZVA/4ecTuOd5RhSFyBk1IEDW+HHMb9ZRBBfeIGlIpM+g5opIC/89Wnd3bCDX6/TKxmPPGoeD0di77ZbyaFaJce2sGXdPL7sMMfD1+XyV2PbkUGFk4GgzmIaffE76tFeOe1VLIAq9URJ1qYLThAMQk4XfWZCAthA0Oh/+EZJ6UCQYfFT/QByKiq87gh9SgdjrdDFASSt3VAEucyxGAGUPpv+wQjPK108CDfzN1kGl8H3d3yIBL4QQRaDVfMCLMOzoFSp4oSRWg8HjMD9U4Aybrjyh2pIKNury28L9NOb+koaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zumsIYvpmqGnJEX7i6w3hdYB1AAH+V+4tOsaB54OXo=;
 b=VhVXddxlgshuTVpE1zJcqaTa4kLF7OPMl5ctikIWlAHMSOxOPWcCOOMDIMmYi9Mm7cj14Ni8WtIERNfJU4MXhRRuTtP+IXMxLvhb3f24xL/0VyW9eoKnzmMivFnJcdHdHVh+u9gLXGQLqeOA8awPHQLBDBsjNcUf/bj0m91djkVvo/sp7uQa7aeuWiO9Rd6ZIBAOm8dZhRroo5D1Dcs6BolHg0ylOCYy+2F7N98aQRrrld9hzqMVnAmOgMHVRynbqZvASqXyb2bu4hgGL0/UOjVjWVWRFodE+2c3yX7FZozcLbNE4YdyWHSdu+meJ5pLMdw0GBj/80QsCO8E8qBc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zumsIYvpmqGnJEX7i6w3hdYB1AAH+V+4tOsaB54OXo=;
 b=e8yuJv+7qXEbLCI7OSJz0JfSGbpYeVzJOi5bsFuK4BKx75inu+Sn9Op6X+PnmJDBRDk8VCNDqHOhYQpu2mCTpDwfdi9SgweA8jSOGtwgDlw4Ff1Unjzg4l/C630MXMyFYoId5SdpTgreJKo4YInAk20boFLC2ltAZlG8j9weL94=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5253.namprd10.prod.outlook.com (2603:10b6:408:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 19:51:46 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e%6]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 19:51:46 +0000
Message-ID: <0f36821d-e0ed-c98e-f39b-ff4b506114e9@oracle.com>
Date:   Tue, 22 Aug 2023 12:51:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: xfstests results over NFS
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Tom Talpey <tom@talpey.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
 <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
 <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
 <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
 <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
 <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
 <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
 <7b2746692aef1725cb000faabf4db2d115279423.camel@kernel.org>
 <25bc018a-00a7-1634-9535-9d01328264d3@oracle.com>
 <b535fccd-acd2-8fca-71ac-6aa17ee84708@oracle.com>
 <cd592a05c13226c5e1fb4f390eb2473ba20024ad.camel@kernel.org>
 <9d1ffe71-83b2-a9c7-861f-0d3f8d715e70@oracle.com>
 <b4b86f10702503b0d056014e77e6d77827f309d1.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <b4b86f10702503b0d056014e77e6d77827f309d1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR01CA0001.prod.exchangelabs.com (2603:10b6:5:296::6) To
 BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BN0PR10MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d9fa1e-2306-4b9c-001c-08dba3493736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8tFU3SXV8M+Lh5Hxv4PKnLG4kKUzVwSs9bXZz8kao+Vc5u+1fyHSsIC85r77R7mwxQ3SwNVS0/xKt6gZ3hcR1B5zYALTct04SB6Y/eRwNlPjW3pH7TQ0zSQg8JD9fP8o+a1UpXYJOp4lxcLRnrkTZC6cCodS9GfDI3tnT4CLK99T+qmPxcTgovTmdL4Lc6BAxUTFq5D1oLYadd4U0dTpnUuBC3Zq2Rb4cOpfTzQIvX5DlD8m+/eEFhXm9vBf1hac65xCsCULVUEfnKuZnSj5vo23UrksCo6IJ+jf83sT2aRNwoJh/oPdU1HvH+djbJV0Jw2keA6mpqKH1PYO7q0BB8NdpSyuGcc/f+96DUxZtaiK1ujnrgDOPSJUd46NaBhJKJ9Q5zveOaiywUTUXuglHQTPiQ32IF3PTTPuFYEVXts6CghS2FJY8zNxdVa1/pWP2iMHp8X4olSaZZcVjtbqB6d573WwumGU9G6rdylF5pxQhhEzsJkS//dWfqlO1igfDZ/mDvX/GEsdL+czM8b8J4atxVtKNvQ+JW5cyNqOVrArznW1Ji2owoDTgfpwE3AvqzXU9Z91wO44EnUui4b4dGH52/MpYpjQs4DA6XTwjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199024)(1800799009)(186009)(83380400001)(478600001)(26005)(31686004)(3480700007)(6506007)(6486002)(2616005)(6512007)(53546011)(6666004)(9686003)(31696002)(86362001)(4326008)(2906002)(30864003)(5660300002)(66556008)(110136005)(38100700002)(54906003)(316002)(66476007)(41300700001)(36756003)(8676002)(8936002)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nklzd1QxemYxQVhrT09HRUxLa1JyRVYxM2M2aytYakpCNU5DeXlhZGFqUkxr?=
 =?utf-8?B?SjJIcW5tbFc4bGdSRkhUaWtOK0hMcjQ1T0o5SjZVUnhna25WVzlQcExBNFYw?=
 =?utf-8?B?ODJOZHlKMWhIV211WmpKSTdpNkEyWEVjSzl2YXdLVUFwQk5oTStrL29QeFBF?=
 =?utf-8?B?ZUduU0wxZWc0Z3lTRGtKeUREOHlnaVBmQzBFYlMya1N1ZVF2bU5JeVhXK28y?=
 =?utf-8?B?Y3B1cDJja1BicmxuOUU2N3ZPR0dnaGxIRWtCQW9UVTNmekhuZkptM0ZsbzNI?=
 =?utf-8?B?VTJIendHR2ZEWldXQlVSUHNDNzJ1NFRrcEU4KzhsQnU3QlA0YUZIOWI0ZDdC?=
 =?utf-8?B?eTc1Y0NLQXNmY1V3cWFDbzFJTUlyWmRid0lwT3M3MFltNm4xRngzZDNLZVNR?=
 =?utf-8?B?OWM2UVpFdDljU2VHWkVYMGFpMnBpTnVQNUYwNUZ5NERLR2FXZTcwY0U3T0hO?=
 =?utf-8?B?eU1QUENlTENDRVJhWGRtMldPRm5TTVNkT3lmUHlNOU5BQTEwOFFoWWRIekdx?=
 =?utf-8?B?aUpySHg4U0dFeTlsZWlsVkpiVHRiakpTZ2pmUlc4d0tCZFJ4dEkxMmg4VHNn?=
 =?utf-8?B?WWVoMUFTYlpqZ3RDaFFDWklCbWIzM0xNd25iNkQvR0hGUlRkNW4vTlB5M3Fi?=
 =?utf-8?B?V2pERS9tSi9wQysxSytFdUJDU3hIRkdzMFN5OEdUdEVjcUVaOGJ1QW5wS2hp?=
 =?utf-8?B?RWt0ZnJzZmZKVVlGbXdVOEZrSGtmcldLWGw5QTR5T3g5K0E1MkNLaUdTVnkx?=
 =?utf-8?B?eThDOXhETmN3L0o0aGlYM09lUWJ0M0twaGZhN2VvQXVtbENiTCtnT1kzcFky?=
 =?utf-8?B?dk9jM3VoOGNvc3YyQ3lvdVFaOFdUZk5XUUxPQzhieW8xd2YwY2ZzQjIwdnhV?=
 =?utf-8?B?VG9MdEYranhXNFFZMWY2dkVFTmlpbkxLR0k5N3pBMWUram9obFBPWWtibVdy?=
 =?utf-8?B?dUhYOU8zQUZkK21aNndBY1FUYndxbnduNmtiWHhoVm1CN0pYWHlLSlR5NHlH?=
 =?utf-8?B?NmZ4ZXZrL3J5Q0dVQ1hEUkwvRUZmYWZ4MzVBT0VWQmowdEErZ3VCQy9GMEo4?=
 =?utf-8?B?OVZvQ291WDJZY2psS0EvSE9xQnVlYTBkOExTVVgvNEEvbFozUnpEeEZKNUoz?=
 =?utf-8?B?Y3ZYSTRhUitRUzBWbXNJK2lIaWJZa1BVOWY4Wnk2M1FjRDBidGhPVzZoZVpM?=
 =?utf-8?B?M0xLTmNNbFhrcXA2eXgwQWFJK3ZFNEdFSXd1QWFyRThQek56MGgvcUlpQUx6?=
 =?utf-8?B?SkFEbFZFUzlSZ1E1cWxyMVc3SWk0TVlNRlhCVWE2SWdVRDJQV2FUK1RXeVRV?=
 =?utf-8?B?bmtYMzZybXlUSG1yaDFYdlA4c0R0UFBuMXd2U3g3QnNyOTZSSlFuQjFWWm8w?=
 =?utf-8?B?TUJ5L01lNnA4dG1ZSExPTG96TStFdFAzSndyM1U1cFV6b2xHYzFRMUlZNVIz?=
 =?utf-8?B?TXpXN090ZWQwdFlEVEZKeUZDTm1SVlEydDFOSHVhYUN3SkpwZG1MSDdwVGhX?=
 =?utf-8?B?YVFONExQNVkwWndGaUVCbVpNVDk0VXV1ZStZQUI0ZlFrMitBM1AzT2RwWkRn?=
 =?utf-8?B?UjhtYVJmN0wrUnQ0Z0k3ektJNit4UTZuSmpxU25pdlBQS1hoNk1xWkttR1Fu?=
 =?utf-8?B?dFZPRnVpM3RpQTloMkNPNFgrQW9vWHJ6bjhkcS94K2swVEpjRll6V2JKcDBa?=
 =?utf-8?B?amRXZnBlM0pndnZ5bGpOblJkVXhhVFA3RWpyUDMrOXEyc2pnbzgxbkR3ZFRX?=
 =?utf-8?B?MFhsY2dqZ2xCQ3cwVThQMENjaW1Eb3VDT0s5SDR0YjhZRDBSMWpWaGRLdGZ0?=
 =?utf-8?B?REVLdmFKMDZjUmZ1V0lYQXEvSHZhMk9hM084amUyU0dDdTc3VlUzcGdyeDgw?=
 =?utf-8?B?dnVNRms1LzBzQVNzblF3NjdBREZDQ1NvbGdqUWZhLzNSbXUzdVlMc2xxbkRp?=
 =?utf-8?B?d2Y0Uys4SHJDbDMvTk5QUm5PYys5bTVhSW83VU5pOFhOZlo0dG1CTVB5VjBQ?=
 =?utf-8?B?ZXptSUJ5ZGZ5RnFrdVYyVjBoL3pwTCtQNjZRRXBNcGFVemdhTG9pQWRsRFZu?=
 =?utf-8?B?aFA1ZlNqSC9XS1hYQldrMjRpVUJ5N3cwOC9jM0FGbFBkMks3aWkvcHNpT0Y3?=
 =?utf-8?Q?kveersojPNZ+7f7pjSAeqYzPI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 28mRcS1PkrvemObTuQHqxi3Fa9BRe7XWa8nyTR844hae8VBUtj2B3n+W+LE0DNhBlXIQicePZh5cA4oZCFKTSc/2RAJZiOleTegWU7IoQ8rDmVgpC63ikwlJbpl0QUicQJfccEbyylHIb/5w30ArZZbAPZl6q36m4jj61VuNJoRfWahQa0tWZygaZeGZkT4u4canZk5sD0jnSStYDzezta3pxOvIWM72652jFhaMgIdkrss7URnk2wOUrq4wnrqiPP7VBgwp1Ia00A64tPwOeSFBwJOHS6AgGCdJF4cAUBVQ/m2uaQJCaYIPe/dkcAhvUyXM66nWLxSYgJxcj9Gy4AFFZyoqFRxeXahGGCRsas6fzuVCQbWik/Jscv5+r8OZrM7FyB7aNCm+YSDgM2BiSytyvW8zWE9U+6Jlf2Qfw4HOGjNIuuncTaQAavuyHYoFEsYduCeuW2EBozDrAoTt4CyOA/p1Je2gBKvJ1B/iIs5w4grRtIIxKrdjCmtTirxw0wOt5/8d3g7OpNb2I+gKznml4IX9fb32HwQxXMxi7LxRPEVc7c6FWKSz4W8jE5/IKiJ3dDIYu3J8YwKqcGq8sjA1+Nbpud3ZQXgNCjmoupF3f/zBPAdKRi8N5x47MqSA8mUeivrY8SW53/0osGCW/0l/ON1EEzYt7LnnN0uYxPC++KRyjHMQIvrLWPjKtsUfnb3YtYB8/RC9dNitxPAp/0O34CUzaIgsr5yvu76z0qKFj4yRqwH9tNWlUVwHcsoFfhnnEPLi2Lck3cwhigYnJPzU53NJli7ulb44wE/jRxbZyywdG26eGrr4gey1deyV8v8XfpeRza3CLm14AI5Kn3j78Lv1lImDlRjk8HG1eop3E8OT3b38WJeVWAK/RyS+dm5drJlG0yNOxr2WN9Bmmw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d9fa1e-2306-4b9c-001c-08dba3493736
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 19:51:45.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxM7+Xk2URgoeX3c+xqacjbuw1t/QDMMA2LC0pz5JQ3nqEehXg0h8crtlWXlMCPbetSfALg05qvHcXjh4G56aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_18,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308220158
X-Proofpoint-GUID: r3HlPBCGelxd5-O5gH0755TayR8w8hqi
X-Proofpoint-ORIG-GUID: r3HlPBCGelxd5-O5gH0755TayR8w8hqi
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/22/23 10:02 AM, Jeff Layton wrote:
> On Tue, 2023-08-22 at 09:07 -0700, dai.ngo@oracle.com wrote:
>> On 8/17/23 4:08 PM, Jeff Layton wrote:
>>> On Thu, 2023-08-17 at 15:59 -0700, dai.ngo@oracle.com wrote:
>>>> On 8/17/23 3:23 PM, dai.ngo@oracle.com wrote:
>>>>> On 8/17/23 2:07 PM, Jeff Layton wrote:
>>>>>> On Thu, 2023-08-17 at 13:15 -0400, Jeff Layton wrote:
>>>>>>> On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
>>>>>>>>> On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>> On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
>>>>>>>>>> On Thu, Aug 17, 2023 at 10:22 AM Jeff Layton <jlayton@kernel.org>
>>>>>>>>>> wrote:
>>>>>>>>>>> On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
>>>>>>>>>>>>> On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org>
>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> I finally got my kdevops
>>>>>>>>>>>>> (https://github.com/linux-kdevops/kdevops) test
>>>>>>>>>>>>> rig working well enough to get some publishable results. To
>>>>>>>>>>>>> run fstests,
>>>>>>>>>>>>> kdevops will spin up a server and (in this case) 2 clients to run
>>>>>>>>>>>>> xfstests' auto group. One client mounts with default options,
>>>>>>>>>>>>> and the
>>>>>>>>>>>>> other uses NFSv3.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I tested 3 kernels:
>>>>>>>>>>>>>
>>>>>>>>>>>>> v6.4.0 (stock release)
>>>>>>>>>>>>> 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
>>>>>>>>>>>>> 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of
>>>>>>>>>>>>> yesterday morning)
>>>>>>>>>>>>>
>>>>>>>>>>>>> Here are the results summary of all 3:
>>>>>>>>>>>>>
>>>>>>>>>>>>> KERNEL:    6.4.0
>>>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>>>
>>>>>>>>>>>>> nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
>>>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/124
>>>>>>>>>>>>>      generic/193 generic/258 generic/294 generic/318 generic/319
>>>>>>>>>>>>>      generic/444 generic/528 generic/529
>>>>>>>>>>>>> nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
>>>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>>>      generic/187 generic/193 generic/294 generic/318 generic/319
>>>>>>>>>>>>>      generic/357 generic/444 generic/486 generic/513 generic/528
>>>>>>>>>>>>>      generic/529 generic/578 generic/675 generic/688
>>>>>>>>>>>>> Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
>>>>>>>>>>>>>
>>>>>>>>>>>>> KERNEL:    6.5.0-rc6-g4853c74bd7ab
>>>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>>>
>>>>>>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
>>>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>>>>>>      generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>>>>>>> nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
>>>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>>>      generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>>>>>>      generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>>>>>>      generic/675 generic/688
>>>>>>>>>>>>> Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
>>>>>>>>>>>>>
>>>>>>>>>>>>> KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
>>>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>>>
>>>>>>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
>>>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>>>>>>      generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>>>>>>> nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
>>>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>>>      generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>>>>>>      generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>>>>>>      generic/675 generic/683 generic/684 generic/688
>>>>>>>>>>>>> Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
>>>>>>>>>> As long as we're sharing results ... here is what I'm seeing with a
>>>>>>>>>> 6.5-rc6 client & server:
>>>>>>>>>>
>>>>>>>>>> anna@gouda ~ % xfstestsdb xunit list --results --runid 1741
>>>>>>>>>> --color=none
>>>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>>>
>>>>>>>>>>> run | device               | xunit   | hostname | pass | fail |
>>>>>>>>>> skip |  time |
>>>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>>>
>>>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
>>>>>>>>>> 464 | 447 s |
>>>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
>>>>>>>>>> 465 | 478 s |
>>>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
>>>>>>>>>> 462 | 404 s |
>>>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
>>>>>>>>>> 363 | 564 s |
>>>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> anna@gouda ~ % xfstestsdb show --failure 1741 --color=none
>>>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>>>>      testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
>>>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>>>> generic/053 | passed  | failure | failure | failure |
>>>>>>>>>>> generic/099 | passed  | failure | failure | failure |
>>>>>>>>>>> generic/105 | passed  | failure | failure | failure |
>>>>>>>>>>> generic/140 | skipped | skipped | skipped | failure |
>>>>>>>>>>> generic/188 | skipped | skipped | skipped | failure |
>>>>>>>>>>> generic/258 | failure | passed  | passed  | failure |
>>>>>>>>>>> generic/294 | failure | failure | failure | failure |
>>>>>>>>>>> generic/318 | passed  | failure | failure | failure |
>>>>>>>>>>> generic/319 | passed  | failure | failure | failure |
>>>>>>>>>>> generic/357 | skipped | skipped | skipped | failure |
>>>>>>>>>>> generic/444 | failure | failure | failure | failure |
>>>>>>>>>>> generic/465 | passed  | failure | failure | failure |
>>>>>>>>>>> generic/513 | skipped | skipped | skipped | failure |
>>>>>>>>>>> generic/529 | passed  | failure | failure | failure |
>>>>>>>>>>> generic/604 | passed  | passed  | failure | passed  |
>>>>>>>>>>> generic/675 | skipped | skipped | skipped | failure |
>>>>>>>>>>> generic/688 | skipped | skipped | skipped | failure |
>>>>>>>>>>> generic/697 | passed  | failure | failure | failure |
>>>>>>>>>>>       nfs/002 | failure | failure | failure | failure |
>>>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>>> With NFSv4.2, v6.4.0 has 2 extra failures that the current
>>>>>>>>>>>>> mainline
>>>>>>>>>>>>> kernel doesn't:
>>>>>>>>>>>>>
>>>>>>>>>>>>>      generic/193 (some sort of setattr problem)
>>>>>>>>>>>>>      generic/528 (known problem with btime handling in client
>>>>>>>>>>>>> that has been fixed)
>>>>>>>>>>>>>
>>>>>>>>>>>>> While I haven't investigated, I'm assuming the 193 bug is also
>>>>>>>>>>>>> something
>>>>>>>>>>>>> that has been fixed in recent kernels. There are also 3 other
>>>>>>>>>>>>> NFSv3
>>>>>>>>>>>>> tests that started passing since v6.4.0. I haven't looked into
>>>>>>>>>>>>> those.
>>>>>>>>>>>>>
>>>>>>>>>>>>> With the linux-next kernel there are 2 new regressions:
>>>>>>>>>>>>>
>>>>>>>>>>>>>      generic/683
>>>>>>>>>>>>>      generic/684
>>>>>>>>>>>>>
>>>>>>>>>>>>> Both of these look like problems with setuid/setgid stripping,
>>>>>>>>>>>>> and still
>>>>>>>>>>>>> need to be investigated. I have more verbose result info on
>>>>>>>>>>>>> the test
>>>>>>>>>>>>> failures if anyone is interested.
>>>>>>>>>> Interesting that I'm not seeing the 683 & 684 failures. What type of
>>>>>>>>>> filesystem is your server exporting?
>>>>>>>>>>
>>>>>>>>> btrfs
>>>>>>>>>
>>>>>>>>> You are testing linux-next? I need to go back and confirm these
>>>>>>>>> results
>>>>>>>>> too.
>>>>>>>> IMO linux-next is quite important : we keep hitting bugs that
>>>>>>>> appear only after integration -- block and network changes in
>>>>>>>> other trees especially can impact the NFS drivers.
>>>>>>>>
>>>>>>> Indeed, I suspect this is probably something from the vfs tree (though
>>>>>>> we definitely need to confirm that). Today I'm testing:
>>>>>>>
>>>>>>>        6.5.0-rc6-next-20230817-g47762f086974
>>>>>>>
>>>>>> Nope, I was wrong. I ran a bisect and it landed here. I confirmed it by
>>>>>> turning off leases on the nfs server and the test started passing. I
>>>>>> probably won't have the cycles to chase this down further.
>>>>>>
>>>>>> The capture looks something like this:
>>>>>>
>>>>>> OPEN (get a write delegation
>>>>>> WRITE
>>>>>> CLOSE
>>>>>> SETATTR (mode 06666)
>>>>>>
>>>>>> ...then presumably a task on the client opens the file again, but the
>>>>>> setuid bits don't get stripped.
>> OPEN (get a write delegation
>> WRITE
>> CLOSE
>> SETATTR (mode 06666)
>>
>> The client continues with:
>>
>> (ALLOCATE,GETATTR)  <<===  this is when the server stripped the SUID and SGID bit
>> READDIR             ====>  file mode shows 0666  (SUID & SGID were stripped)
>> READDIR             ====>  file mode shows 0666  (SUID & SGID were stripped)
>> DELERETURN
>>
>> Here is stack trace of ALLOCATE when the SUID & SGID were stripped:
>>
>> **** start of notify_change, notice the i_mode bits, SUID & SGID were set:
>> [notify_change]: d_iname[a] ia_valid[0x1a00] ia_mode[0x0] i_mode[0x8db6] [nfsd:2409:Mon Aug 21 23:05:31 2023]
>>                           KILL[0] KILL_SUID[1] KILL_SGID[1]
>>
>> **** end of notify_change, notice the i_mode bits, SUID & SGID were stripped:
>> [notify_change]: RET[0] d_iname[a] ia_valid[0x1a01] ia_mode[0x81b6] i_mode[0x81b6] [nfsd:2409:Mon Aug 21 23:05:31 2023]
>>
>> **** stack trace of notify_change comes from ALLOCATE:
>> Returning from:  0xffffffffb726e764 : notify_change+0x4/0x500 [kernel]
>> Returning to  :  0xffffffffb726bf99 : __file_remove_privs+0x119/0x170 [kernel]
>>    0xffffffffb726cfad : file_modified_flags+0x4d/0x110 [kernel]
>>    0xffffffffc0a2330b : xfs_file_fallocate+0xfb/0x490 [xfs]
>>    0xffffffffb723e7d8 : vfs_fallocate+0x158/0x380 [kernel]
>>    0xffffffffc0ddc30a : nfsd4_vfs_fallocate+0x4a/0x70 [nfsd]
>>    0xffffffffc0def7f2 : nfsd4_allocate+0x72/0xc0 [nfsd]
>>    0xffffffffc0df2663 : nfsd4_proc_compound+0x3d3/0x730 [nfsd]
>>    0xffffffffc0dd633b : nfsd_dispatch+0xab/0x1d0 [nfsd]
>>    0xffffffffc0bda476 : svc_process_common+0x306/0x6e0 [sunrpc]
>>    0xffffffffc0bdb081 : svc_process+0x131/0x180 [sunrpc]
>>    0xffffffffc0dd4864 : nfsd+0x84/0xd0 [nfsd]
>>    0xffffffffb6f0bfd6 : kthread+0xe6/0x120 [kernel]
>>    0xffffffffb6e587d4 : ret_from_fork+0x34/0x50 [kernel]
>>    0xffffffffb6e03a3b : ret_from_fork_asm+0x1b/0x30 [kernel]
>>
>> I think the problem here is that the client does not update the file
>> attribute after ALLOCATE. The GETATTR in the ALLOCATE compound does
>> not include the mode bits.
>>
> Oh, interesting! Have you tried adding the FATTR4_MODE to that GETATTR
> call on the client? Does it also fix this?

Yes, this is what I'm going to try next.

>
>> The READDIR's reply show the test file's mode has the SUID & SGID bit
>> stripped (0666) but apparently these were not used o update the file
>> attribute.
>>
>> The test passes when server does not grant write delegation because:
>>
>> OPEN
>> WRITE
>> CLOSE
>> SETATTR (06666)
>> OPEN (CLAIM_FH, NOCREATE)
>> ALLOCATE        <<=== server clear SUID & SGID
>> GETATTR, CLOSE  <<=== GETATTR has mode bit as 0666, client updates file attribute
>> READDIR
>> READDIR
>>
>> As expected, if the server recalls the write delegation when SETATTR
>> with SUID/SGID set then the test passes. This is because it forces the
>> client to send the 2nd OPEN with CLAIM_FH, NOCREATE and then the
>> (GETATTR, CLOSE) which cause the client to update the file attribute.
>>
> What's your sense of the best way to fix this? The stripping of mode
> bits isn't covered by the NFSv4 spec, so this will ultimately come down
> to a judgment call.

Yes, I did not find anything regarding stripping of SUID/SGID in the NFS4.2
specs. It's done by the 'fs' layer and it has been there since 4/2005 in
the big merge to Linux-2.6.12-rc2 done by Linus. So I think we should leave
it there.

The stripping makes some sense to me since if the file is being expanded
(to be written to) then it should not an executable therefor its SUID/SGID
should be stripped.

-Dai

